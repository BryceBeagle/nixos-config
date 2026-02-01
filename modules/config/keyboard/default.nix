{
  delib,
  inputs,
  lib,
  ...
}:
delib.module {
  name = "keyboard";

  home.always = {myconfig, ...}: {
    dconf = lib.mkIf myconfig.desktop-environment.gnome.enable {
      settings = with inputs.home-manager.lib.hm.gvariant; {
        "org/gnome/desktop/peripherals/keyboard" = {
          # Initial delay (ms)
          delay = mkUint32 300;
          # Delay between inputs (ms)
          repeat-interval = mkUint32 15;
        };
      };
    };

    programs.niri = lib.mkIf myconfig.desktop-environment.niri.enable {
      settings.input.keyboard = {
        # Initial delay (ms)
        repeat-delay = 300;
        # Characters per second
        repeat-rate = 67;
      };
    };
  };
}
