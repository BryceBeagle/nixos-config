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
  }: {
    services.udev.extraRules = lib.mkMerge [
      # Symlink the eGPU to standardized path so it can be used by arbitrary tools
      (
        lib.concatStrings [
          ''SUBSYSTEM=="drm", ''
          ''ACTION=="add", ''
          ''ATTRS{vendor}=="${cfg.vendorId}", ''
          ''ATTRS{device}=="${cfg.deviceId}", ''
          ''SYMLINK+="dri/by-name/egpu"''
        ]
      )
      # Tell Gnome/mutter to use the eGPU as the "primary" GPU
      # https://gitlab.gnome.org/GNOME/mutter/-/blob/main/doc/multi-gpu.md
      (
        lib.mkIf myconfig.desktop-environment.gnome.enable (
          lib.concatStrings [
            ''SUBSYSTEM=="drm", ''
            ''ENV{DEVTYPE}=="drm_minor", ''
            ''ENV{DEVNAME}=="/dev/dri/card[0-9]", ''
            ''SUBSYSTEMS=="pci", ''
            ''ATTRS{vendor}=="${cfg.vendorId}", ''
            ''ATTRS{device}=="${cfg.deviceId}", ''
            ''TAG+="mutter-device-preferred-primary"''
          ]
        )
      )
    ];
  };

  home.ifEnabled = {myconfig, ...}: {
    programs = lib.optionalAttrs myconfig.desktop-environment.niri.enable {
      niri.settings = {
        # Use the symlink created above as the preference. If this symlink is missing,
        # niri appears to be fine falling back to whatever it would have otherwise
        # chosen
        debug.render-drm-device = "/dev/dri/by-name/egpu";
      };
    };
  };
}
