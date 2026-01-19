{
  delib,
  lib,
  ...
}:
delib.module {
  name = "touchpad";

  darwin.always.system.defaults.NSGlobalDomain = {
    # Completely disable Force Click. This is the only way I can find to turn off the
    # annoying dictionary/lookup utility when force clicking words. I have never
    # encountered another thing that uses Force Click, so completely disabling this
    # doesn't bother me.
    "com.apple.trackpad.forceClick" = false;
  };

  home.always = {myconfig, ...}:
    lib.mkMerge [
      (lib.mkIf myconfig.desktop-environment.gnome.enable {
        dconf.settings = {
          "org/gnome/desktop/peripherals/touchpad" = {
            natural-scroll = false;
          };
        };
      })
      (lib.mkIf myconfig.desktop-environment.niri.enable {
        programs.niri.settings.input.touchpad.natural-scroll = false;
      })
    ];
}
