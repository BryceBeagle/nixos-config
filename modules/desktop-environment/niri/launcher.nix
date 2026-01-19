{delib, ...}:
delib.module {
  name = "desktop-environment.niri";

  home.ifEnabled.programs.vicinae = {
    enable = true;

    systemd.enable = true;
  };
}
