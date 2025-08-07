{delib, ...}:
delib.module {
  name = "bluetooth";

  myconfig.always.persist.system.directories = [
    # Known devices are stored here
    "/var/lib/bluetooth/"
  ];
}
