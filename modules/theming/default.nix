{
  config,
  delib,
  homeManagerUser,
  inputs,
  ...
}:
delib.module {
  name = "theming";

  options = delib.singleEnableOption true;

  nixos.always.imports = [
    inputs.stylix.nixosModules.stylix
  ];

  home.always.imports = [
    inputs.stylix.homeModules.stylix
  ];

  home.ifEnabled = {
    stylix = {
      enable = true;

      # Unfortunately, seems to not do anything
      # https://github.com/BryceBeagle/nixos-config/issues/351
      targets.firefox.profileNames = ["default"];
    };

    # TODO: Remove when this upstream issue is resolved:
    # https://github.com/nix-community/stylix/issues/2250
    gtk.gtk4.theme = config.home-manager.users.${homeManagerUser}.gtk.theme;
  };
}
