{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "desktop-environment.macos";

  options = delib.singleEnableOption false;

  darwin.ifEnabled.system.defaults = {
    dock = {
      autohide = true;
      show-recents = false;
      static-only = true; # only show opened applications
      tilesize = 15; # teeny tiny. 20 is the typical minimum using dragger
    };
  };

  home.ifEnabled.home.packages = with pkgs; [
    alt-tab-macos
    ice-bar
  ];
}
