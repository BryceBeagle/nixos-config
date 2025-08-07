{delib, ...}:
delib.module {
  name = "screen";

  myconfig.always.impermanence.system.directories = [
    # Backlight value(s) from previous boot. The files in here are written at
    # poweroff and read at startup.
    # We could consider forcing a value into the file(s) instead of persisting
    # the previous boot's state.
    "/var/lib/systemd/backlight/"
  ];
}
