{delib, ...}:
delib.module {
  name = "bluetooth";

  myconfig.always.impermanence.system.directories = [
    # Known devices are stored here
    "/var/lib/bluetooth/"
  ];
}
