{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "desktop-environment.macos";

  options = delib.singleEnableOption false;

  home.ifEnabled.home.packages = with pkgs; [
    alt-tab-macos
    ice-bar
  ];

  darwin.ifEnabled.system.defaults = {
    dock.show-recents = false;
  };
}
