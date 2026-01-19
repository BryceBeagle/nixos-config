{delib, ...}:
delib.module {
  name = "desktop-environment.niri";

  home.ifEnabled.programs = {
    waybar = {
      enable = true;

      systemd.enable = true;
    };
  };
}
