{
  delib,
  lib,
  ...
}:
delib.module {
  name = "theming";

  home.ifEnabled = {myconfig, ...}: {
    programs = lib.optionalAttrs myconfig.desktop-environment.niri.enable {
      niri.settings = {
        prefer-no-csd = true;

        window-rules = [
          {
            clip-to-geometry = true;

            # For some reason, niri itself allows setting this to a single int/float,
            # if all values are the same, but the niri flake requires it to be a full
            # attrset of floats
            geometry-corner-radius = {
              bottom-left = 18.0;
              bottom-right = 18.0;
              top-left = 18.0;
              top-right = 18.0;
            };
          }
        ];
      };
    };
  };
}
