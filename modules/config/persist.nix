{
  delib,
  inputs,
  lib,
  ...
}:
delib.module {
  name = "persist";

  nixos.always.imports = [
    inputs.impermanence.nixosModules.impermanence
  ];
  home.always.imports = [
    inputs.impermanence.homeManagerModules.impermanence
  ];

  options.persist = with delib; let
    persistPathType = lib.types.oneOf [str attrsLegacy];
  in {
    enable = boolOption false;

    system = {
      # Required because this cannot be deduced
      persistRoot = noDefault (strOption null);

      directories = listOfOption persistPathType [];
      files = listOfOption persistPathType [];
    };

    user = {
      # Required because this cannot be deduced
      persistRoot = noDefault (strOption null);

      directories = listOfOption persistPathType [];
      files = listOfOption persistPathType [];
    };
  };

  nixos.ifEnabled = {cfg, ...}: {
    # required for 'home-manager...home.persistence.allowOther = true'
    programs.fuse.userAllowOther = true;

    environment.persistence.${cfg.system.persistRoot} = {
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
  };

  home.ifEnabled = {cfg, ...}: {
    home.persistence."${cfg.user.persistRoot}" = {
      enable = true;

      allowOther = true;

      directories = cfg.user.directories;
      files = cfg.user.files;
    };
  };
}
