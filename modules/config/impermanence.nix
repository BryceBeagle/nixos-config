{
  delib,
  inputs,
  lib,
  ...
}:
delib.module {
  name = "impermanence";

  nixos.always.imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  options.impermanence = with delib; let
    persistPathType = lib.types.oneOf [str attrsLegacy];
  in {
    enable = boolOption false;

    # Required because this cannot be deduced
    persistRoot = noDefault (strOption null);

    system = {
      directories = listOfOption persistPathType [];
      files = listOfOption persistPathType [];
    };

    user = {
      directories = listOfOption persistPathType [];
      files = listOfOption persistPathType [];
    };
  };

  nixos.ifEnabled = {cfg, ...}: {
    environment.persistence."${cfg.persistRoot}" = {
      enable = true;

      hideMounts = true;

      directories = (
        cfg.system.directories
        # Entries in this list will _always_ need to be persisted, regardless of
        # configuration.
        ++ [
          "/var/lib/nixos"
        ]
      );
      files = (
        cfg.system.files
        # Entries in this list will _always_ need to be persisted, regardless of
        # configuration.
        ++ [
          "/etc/machine-id"
        ]
      );
    };

    # Super important until https://github.com/NixOS/nixpkgs/pull/435781 is default!
    # Otherwise, no initrd service will be created
    boot.initrd.systemd.enable = true;

    boot.initrd.systemd.services.wipe-btrfs-root = {
      description = "Wipe root btrfs subvolume for impermanence";
      wantedBy = ["initrd.target"];

      # This must match the actual btfrs device label (it's also used in the script)
      # TODO: Encode/pass this as configuration
      after = ["dev-disk-by\\x2dlabel-nixos.device"];
      requires = ["dev-disk-by\\x2dlabel-nixos.device"];

      # Must happen after the device is ready, but before /sysroot is mounted.
      before = ["sysroot.mount"];

      unitConfig.DefaultDependencies = "no";
      serviceConfig.Type = "oneshot";

      script = ''
        mkdir /btrfs_tmp
        mount /dev/disk/by-label/nixos /btrfs_tmp
        if [[ -e /btrfs_tmp/@ ]]; then
            mkdir -p /btrfs_tmp/old_roots
            timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/@)" "+%Y-%m-%-d_%H:%M:%S")
            mv /btrfs_tmp/@ "/btrfs_tmp/old_roots/$timestamp"
        fi

        delete_subvolume_recursively() {
            IFS=$'\n'
            for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
                delete_subvolume_recursively "/btrfs_tmp/$i"
            done
            btrfs subvolume delete "$1"
        }

        for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
            delete_subvolume_recursively "$i"
        done

        btrfs subvolume create /btrfs_tmp/@
        umount /btrfs_tmp
      '';
    };
  };

  home.ifEnabled = {cfg, ...}: {
    home.persistence."${cfg.persistRoot}" = {
      enable = true;

      directories = cfg.user.directories;
      files = cfg.user.files;
    };
  };
}
