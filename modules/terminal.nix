{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "terminal";

  options = delib.singleEnableOption true;

  myconfig.ifEnabled.impermanence.user.directories = [
    # `direnv allow`-ed directories
    ".local/share/direnv/allow"
    # fish_history. Needs to be dir because Fish overwrites symlinks
    ".local/share/fish"
  ];

  # Default terminal configuration for other users
  nixos.ifEnabled = {
    # TTY font
    console.font = "Lat2-Terminus16";

    # Default shell for all users
    users.defaultUserShell = pkgs.fish;

    # Other assorted, globally installed packages
    environment.systemPackages = with pkgs; [
      curl
      jq
      just
      libinput
      ripgrep
      tree
      unzip
      usbutils
      wget
    ];

    programs = {
      fish.enable = true;

      # Backup if fish isn't working for some reason
      zsh.enable = true;

      neovim = {
        enable = true;

        defaultEditor = true;
      };
    };
  };

  home.ifEnabled.programs = {
    direnv = {
      enable = true;

      silent = true;
    };

    fish = {
      enable = true;

      functions = {
        # Disable "Welcome to fish" message
        fish_greeting = "";
      };
    };

    ghostty = {
      enable = true;

      settings = {
        cursor-invert-fg-bg = true;
        theme = "catppuccin-macchiato";
        window-decoration = "none";
      };
    };
  };
}
