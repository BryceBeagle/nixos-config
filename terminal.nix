{ ... }: {
  home.persistence."/persist/home/ignormies" = {
    directories = [
      # Contains fish_history. Needs to be dir because Fish overwrites symlinks
      ".local/share/fish"
    ];
  };

  programs.ghostty = {
    enable = true;

    settings = {
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
