{delib, ...}:
delib.module {
  name = "logging";

  myconfig.always.persist.system.directories = [
    "/var/lib/systemd/coredump/"
    "/var/log/"
  ];
}
