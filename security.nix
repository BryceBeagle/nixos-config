{ ... }: {
  security = {
    # Without this, impermanance makes sudo give lecture every reboot
    sudo.extraConfig = "Defaults lecture = never";
 
    # Shorten delay-on-failure from 3 seconds to 0.5 seconds.
    # Technically this is less secure, but I'm not going to worry about a 6x
    # speed-up for brute forces.
    pam.services.sudo = {
      nodelay = true;
      failDelay = {
        enable = true;
        delay = 500000;
      };
    };
  };

  users = {
    # Prevent users created outside of nix config
    mutableUsers = false;

    users.ignormies = {
      isNormalUser = true;
      extraGroups = [
        # Configure network settings
        "networkmanager"
        # Use sudo
        "wheel"
      ];
      initialPassword = "foobar";
    };
  };
}
