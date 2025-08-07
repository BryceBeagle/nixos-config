{delib, ...}:
delib.module {
  name = "logging";

  myconfig.always.impermanence.system.directories = [
    "/var/lib/systemd/coredump/"
    "/var/log/"
  ];
}
