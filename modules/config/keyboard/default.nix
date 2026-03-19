{
  delib,
  inputs,
  lib,
  ...
}:
delib.module {
  name = "keyboard";

  darwin.always.system.defaults = {
    NSGlobalDomain = {
      # Initial delay (15ms per)
      InitialKeyRepeat = 10;
      # Delay between inputs (15ms per)
      KeyRepeat = 1;
    };
  };

  home.always = {myconfig, ...}: {
    dconf = lib.mkIf myconfig.desktop-environment.gnome.enable {
      settings = with inputs.home-manager.lib.hm.gvariant; {
        "org/gnome/desktop/peripherals/keyboard" = {
          # Initial delay (ms)
          delay = mkUint32 150;
          # Delay between inputs (ms)
          repeat-interval = mkUint32 15;
        };
      };
    };

    programs = lib.optionalAttrs myconfig.desktop-environment.niri.enable {
      niri.settings.input.keyboard = {
        # Initial delay (ms)
        repeat-delay = 150;
        # Characters per second
        repeat-rate = 67;
      };
    };
  };
}
