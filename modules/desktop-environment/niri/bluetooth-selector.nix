{
  delib,
  inputs,
  pkgs,
  ...
}:
delib.module {
  name = "desktop-environment.niri";

  home.ifEnabled.programs.vicinae.extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
    bluetooth
  ];
}
