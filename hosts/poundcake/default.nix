{delib, ...}:
delib.host {
  name = "poundcake";

  nixos.system.stateVersion = "24.05";
  home.home.stateVersion = "24.05";

  myconfig = {
    user = {
      username = "ignormies";
      initialPassword = "foobar";
    };

    persist = {
      enable = true;

      system.persistPath = "/persist";
      user.persistPath = "/persist/home/ignormies";
    };

    discord.enable = true;
    firefox.enable = true;
    spotify.enable = true;

    desktop-environment = {
      enable = true;

      gnome.enable = true;
    };

    xdg.defaultApplications.pdf = ["firefox.desktop"];
  };
}
