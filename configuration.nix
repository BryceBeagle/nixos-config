# Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ inputs, lib, pkgs, ... }: {

  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.impermanence.nixosModules.impermanence
  ];

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    flake-registry = "";
  };
  nix.channel.enable = false;

  # Use systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Persist some system directories
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/log/"
      "/var/lib/nixos/"
      "/var/lib/alsa/"
      "/var/lib/bluetooth/"
      # Backlight value(s) from previous boot. The files in here are written at
      # poweroff and read at startup.
      # We could consider forcing a value into the file(s) instead of persisting
      # the previous boot's state.
      "/var/lib/systemd/backlight/"
      "/var/lib/systemd/coredump/"
      "/etc/NetworkManager/system-connections/"
    ];
  };

  # Without this, impermanance makes sudo give lecture every reboot
  security.sudo.extraConfig = "Defaults lecture = never";

  networking.hostName = "poundcake";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Los_Angeles";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  services = {
    fwupd.enable = true;

    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    gnome.core-apps.enable = false;

    # Enable sound.
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      pulse.enable = true;
    };

    xserver = {
      enable = true;
      excludePackages = [ pkgs.xterm ];

      # If xkbOptions are set in dconf config, they shadow this. Do not do.
      # https://discourse.nixos.org/t/setting-caps-lock-as-ctrl-not-working/11952
      xkb.options = "compose:ralt,ctrl:nocaps";
    };
  };

  environment.gnome.excludePackages = with pkgs; [
    gnome-shell-extensions
    gnome-tour
  ];

  environment.systemPackages = with pkgs; [
    # CLI tools
    claude-code
    curl
    ghostty
    jq
    just
    libinput
    neovim
    ripgrep
    tree
    unzip
    usbutils
    wget

    # Gnome tools
    loupe
    gedit
    baobab
    gnome-calculator
    gnome-screenshot
    gnome-system-monitor
    gnome-tweaks
    nautilus
    gnomeExtensions.just-perfection
    gnomeExtensions.paperwm

    # Programming
    cargo
    exercism
    gcc
    rust-analyzer
    rustc

    # Human programs
    discord
    timeshift
  ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "claude-code"
      "discord"
    ];

  # fontconfig must be enabled in home-manager config
  fonts.packages = with pkgs; [
    noto-fonts
    nerd-fonts.jetbrains-mono
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];

  programs.fuse.userAllowOther = true;  # required for 'home-manager...home.persistence.allowOther = true'
  programs.git.enable = true;

  programs.zsh.enable = true;
  programs.fish.enable = true;

  # Default shell for users (i.e. in a terminal emulator)
  users.defaultUserShell = pkgs.fish;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  users.mutableUsers = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ignormies = {
    isNormalUser = true;
    extraGroups = [
      # Configure network settings
      "networkmanager"
      # Use sudo
      "wheel"
    ];
    initialPassword = "foobar";
  };

  home-manager = {
    # Implicitly passed to all modules under 'imports'. `inputs' is not a default
    # 'specialArg', so it needs to be listed.
    extraSpecialArgs = { inherit inputs; };

    users.ignormies = { lib, ... }: {
      imports = [
        inputs.impermanence.homeManagerModules.impermanence

        inputs.nix-colors.homeManagerModules.default
        inputs.nixvim.homeManagerModules.nixvim
        inputs.spicetify-nix.homeManagerModules.default

        ./neovim
        ./discord.nix
        ./firefox.nix
        ./git.nix
        ./gnome.nix
        ./spotify.nix
        ./terminal.nix
        ./xdg.nix
      ];

      programs.home-manager.enable = true;

      home.persistence."/persist/home/ignormies" = {
        directories = [
          ".ssh"
        ];
        files = [
          # API token stored here
          ".config/exercism/user.json"
        ];
        allowOther = true;
      };

      # From https://wiki.nixos.org/wiki/Fonts:
      # > Nix inserts its user profile path into $XDG_DATA_DIRS, which Fontconfig by
      # > default doesn't look in. This cause graphical applications like KDE Plasma not
      # > able to recognize the fonts installed via nix-env or nix profile.
      fonts.fontconfig.enable = true;

      home.stateVersion = "24.05";
    };
  };

  system.stateVersion = "24.05";
}
