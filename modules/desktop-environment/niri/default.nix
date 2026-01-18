{
  delib,
  inputs,
  pkgs,
  ...
}:
delib.module {
  name = "desktop-environment.niri";

  options = delib.singleEnableOption false;

  nixos.always.imports = [
    inputs.niri.nixosModules.niri
  ];

  nixos.ifEnabled.programs.niri = {
    enable = true;

    # Use upstream package instead of the random binary cached with the flake
    # https://github.com/sodiboo/niri-flake#binary-cache
    package = pkgs.niri;
  };
}
