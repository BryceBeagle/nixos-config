{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "desktop-environment";

  options = delib.singleEnableOption true;

  nixos.ifEnabled.services.xserver = {
    enable = true;

    excludePackages = [pkgs.xterm];
  };
}
