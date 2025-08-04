{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "desktop-environment";

  options = delib.singleEnableOption true;

  nixos.ifEnabled.services = {
    displayManager.gdm.enable = true;

    xserver = {
      enable = true;

      excludePackages = [pkgs.xterm];
    };
  };
}
