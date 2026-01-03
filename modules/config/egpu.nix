{
  delib,
  lib,
  ...
}:
delib.module {
  name = "egpu";

  options.egpu = with delib; {
    enable = boolOption false;

    vendorId = noDefault (strOption null);
    deviceId = noDefault (strOption null);
  };

  nixos.ifEnabled = {
    cfg,
    myconfig,
    ...
  }:
    lib.mkIf myconfig.desktop-environment.gnome.enable {
      # Tell Gnome/mutter to use the eGPU as the "primary" GPU
      # https://gitlab.gnome.org/GNOME/mutter/-/blob/main/doc/multi-gpu.md
      services.udev.extraRules = lib.concatStrings [
        ''SUBSYSTEM=="drm", ''
        ''ENV{DEVTYPE}=="drm_minor", ''
        ''ENV{DEVNAME}=="/dev/dri/card[0-9]", ''
        ''SUBSYSTEMS=="pci", ''
        ''ATTRS{vendor}=="${cfg.vendorId}", ''
        ''ATTRS{device}=="${cfg.deviceId}", ''
        ''TAG+="mutter-device-preferred-primary"''
      ];
    };
}
