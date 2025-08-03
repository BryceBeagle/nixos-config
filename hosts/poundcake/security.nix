{inputs, ...}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
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

  users = {
    users.ignormies = {
      extraGroups = [
        # Use sudo
        "wheel"
      ];
    };
  };

  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      # fprint stores fingerprints here. We'll persist for primary user
      {
        directory = "/var/lib/fprint/ignormies/";
        mode = "0700";
      }
    ];
  };

  home-manager.users.ignormies.home.persistence."/persist/home/ignormies" = {
    directories = [
      ".local/share/keyrings/"
      ".ssh/"
    ];
  };
}
