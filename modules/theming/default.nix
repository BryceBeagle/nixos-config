{
  delib,
  inputs,
  ...
}:
delib.module {
  name = "theming";

  options = delib.singleEnableOption true;

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
  };
}
