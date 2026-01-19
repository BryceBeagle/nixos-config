{
  delib,
  lib,
  ...
}:
delib.module {
  name = "displays";

  myconfig.always.impermanence.system.directories = [
    # Backlight value(s) from previous boot. The files in here are written at
    # poweroff and read at startup.
    # We could consider forcing a value into the file(s) instead of persisting
    # the previous boot's state.
    "/var/lib/systemd/backlight/"
  ];

  home.always = {myconfig, ...}: {
    programs.niri = lib.mkIf myconfig.desktop-environment.niri.enable {
      settings.outputs = {
        # Framework 16 internal display
        "BOE 0x0BC9 Unknown" = {
          scale = 1; # Defaults to 1.5 for some reason
        };
      };
    };
  };
}
