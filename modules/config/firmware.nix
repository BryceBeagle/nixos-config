{delib, ...}:
delib.module {
  name = "firmware";

  nixos.always.services.fwupd.enable = true;
}
