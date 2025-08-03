{delib, ...}:
delib.host {
  name = "poundcake";

  nixos.system.stateVersion = "24.05";
  home.home.stateVersion = "24.05";

  myconfig = {
    discord.enable = true;
    firefox.enable = true;
    spotify.enable = true;

    desktop-environment.gnome.enable = true;

    xdg = {
      enable = true;

      defaultApplications.pdf = ["firefox.desktop"];
    };
  };
}
