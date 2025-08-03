{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../home

    ./embedded.nix
    ./security.nix
  ];

  nix = {
    channel.enable = false;

    # Not sure if this is strictly required, but recommended by
    # https://github.com/nix-community/nixd/blob/main/nixd/docs/configuration.md
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];

    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      flake-registry = "";
    };
  };

  # Persist some system directories
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/etc/NetworkManager/system-connections/"
      "/var/log/"
      "/var/lib/alsa/"
      "/var/lib/bluetooth/"
      # Backlight value(s) from previous boot. The files in here are written at
      # poweroff and read at startup.
      # We could consider forcing a value into the file(s) instead of persisting
      # the previous boot's state.
      "/var/lib/systemd/backlight/"
      "/var/lib/systemd/coredump/"
    ];
  };

  networking.hostName = "poundcake";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Los_Angeles";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  services = {
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    fwupd.enable = true;
    gnome.core-apps.enable = false;

    # Enable sound.
    pipewire = {
      enable = true;
      # Use as primary audio server, in lieu of pulseaudio/jack
      audio.enable = true;
    };

    xserver = {
      enable = true;
      excludePackages = [pkgs.xterm];

      # If xkbOptions are set in dconf config, they shadow this. Do not do.
      # https://discourse.nixos.org/t/setting-caps-lock-as-ctrl-not-working/11952
      xkb.options = "compose:ralt,ctrl:nocaps";
    };
  };

  environment.gnome.excludePackages = with pkgs; [
    gnome-shell-extensions
    gnome-tour
  ];

  # Globally enabled for all users
  environment.systemPackages = with pkgs; [
    # CLI tools
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

    # Useful for LSPs and other file-editing
    cargo
    rust-analyzer
  ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "discord"
      "spotify"
    ];

  programs.git.enable = true;

  programs.zsh.enable = true;
  programs.fish.enable = true;

  # Default shell for users (i.e. in a terminal emulator)
  users.defaultUserShell = pkgs.fish;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
}
