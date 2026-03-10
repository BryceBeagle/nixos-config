{
  delib,
  lib,
  ...
}:
delib.module {
  name = "theming";

  home.ifEnabled = {myconfig, ...}: {
    programs = lib.optionalAttrs myconfig.desktop-environment.niri.enable {
      niri.settings.prefer-no-csd = true;
    };
  };
}
