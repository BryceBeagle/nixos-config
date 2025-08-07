{delib, ...}:
delib.module {
  name = "security";

  myconfig.always = {myconfig, ...}: {
    impermanence = {
      system.directories = [
        # fprint stores fingerprints here. We'll persist for primary user
        {
          directory = "/var/lib/fprint/${myconfig.user.username}/";
          mode = "0700";
        }
      ];
      user.directories = [
        ".local/share/keyrings/"
        ".ssh/"
      ];
    };
  };

  nixos.always = {myconfig, ...}: {
    users.users.${myconfig.user.username}.extraGroups = [
      # Allow sudo usage
      "wheel"
    ];

    security = {
      # Without this, impermanance makes sudo give lecture every reboot
      sudo.extraConfig = "Defaults lecture = never";

      # Shorten delay-on-failure from 3 seconds to 0.5 seconds.
      # Technically this is less secure, but I'm not going to worry about a 6x
      # speed-up for brute forces.
      pam.services = let
        shortenFailDelay = {
          nodelay = true;
          failDelay = {
            enable = true;
            delay = 500000;
          };
        };
      in {
        login = shortenFailDelay;
        sudo = shortenFailDelay;
      };
    };
  };
}
