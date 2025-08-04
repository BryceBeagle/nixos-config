{
  delib,
  lib,
  ...
}:
delib.module {
  name = "touchpad";

  home.always = {myconfig, ...}:
    lib.mkIf myconfig.desktop-environment.gnome.enable {
      dconf.settings = {
        "org/gnome/desktop/peripherals/touchpad" = {
          natural-scroll = false;
        };
      };
    };
}
