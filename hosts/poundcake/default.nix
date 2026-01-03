{
  delib,
  inputs,
  ...
}:
delib.host {
  name = "poundcake";

  nixos.system.stateVersion = "24.05";
  home.home.stateVersion = "24.05";

  myconfig = {
    user = {
      username = "ignormies";
      initialPassword = "foobar";
    };

    impermanence = {
      enable = true;

      system.persistRoot = "/persist";
      user.persistRoot = "/persist/home/ignormies";
    };

    desktop-environment = {
      enable = true;

      gnome.enable = true;

      xdg = {
        enable = true;

        defaultApplications.pdf = ["firefox.desktop"];
      };
    };

    programs = {
      discord.enable = true;
      firefox.enable = true;
      spotify.enable = true;
      steam.enable = true;
    };

    extras = {
      embedded.enable = true;
      exercism.enable = true;

      egpu = {
        enable = true;

        vendorId = "0x1002"; # AMD
        deviceId = "0x731f"; # Radeon RX 5700 XT
      };
    };
  };

  nixos.imports = [
    inputs.nixos-hardware.nixosModules.framework-16-7040-amd
  ];
}
