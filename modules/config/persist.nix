{
  delib,
  inputs,
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

  options.persist = with delib; {
    enable = boolOption false;

    system = {
      # Required because this cannot be deduced
      persistPath = noDefault (strOption null);

      directories = listOfOption str [];
      files = listOfOption str [];
    };

    user = {
      # Required because this cannot be deduced
      persistPath = noDefault (strOption null);

      directories = listOfOption str [];
      files = listOfOption str [];
    };
  };

  nixos.ifEnabled = {cfg, ...}: {
    # required for 'home-manager...home.persistence.allowOther = true'
    programs.fuse.userAllowOther = true;

    environment.persistence.${cfg.system.persistPath} = {
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
      files = cfg.system.files;
    };
  };

  home.ifEnabled = {cfg, ...}: {
    home.persistence."${cfg.user.persistPath}" = {
      enable = true;

      allowOther = true;

      directories = cfg.user.directories;
      files = cfg.user.files;
    };
  };
}
