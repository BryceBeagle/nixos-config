{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.terminal";

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

  darwin.always = {myconfig, ...}: {
    # ghostty is marked as broken on darwin. We have to install it with homebrew.
    # The home-manager config will still apply.
    # https://github.com/NixOS/nixpkgs/issues/388984
    homebrew.casks = ["ghostty"];
    home-manager.users.${myconfig.user.username}.programs.ghostty.package = null;

    # This uses the system-installed fish as the default user shell, but the config
    # in home-manager will still apply
    programs.fish.enable = true;
    users.users.${myconfig.user.username}.shell = pkgs.fish;
  };
}
