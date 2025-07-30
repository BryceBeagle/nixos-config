{...}: {
  home.persistence."/persist/home/ignormies" = {
    directories = [
      # `direnv allow`-ed directories
      ".local/share/direnv/allow"
      # fish_history. Needs to be dir because Fish overwrites symlinks
      ".local/share/fish"
    ];
  };

  programs.direnv = {
    enable = true;

    silent = true;
  };

  programs.ghostty = {
    enable = true;

    settings = {
      cursor-invert-fg-bg = true;
      theme = "catppuccin-macchiato";
      window-decoration = "none";
    };
  };

  programs.fish = {
    enable = true;

    functions = {
      # Disable "Welcome to fish" message
      fish_greeting = "";
    };
  };
}
