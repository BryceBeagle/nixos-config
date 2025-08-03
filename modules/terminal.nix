{delib, ...}:
delib.module {
  name = "terminal";

  options = delib.singleEnableOption true;

  myconfig.ifEnabled.persist.user.directories = [
    # `direnv allow`-ed directories
    ".local/share/direnv/allow"
    # fish_history. Needs to be dir because Fish overwrites symlinks
    ".local/share/fish"
  ];

  home.ifEnabled.programs.direnv = {
    enable = true;

    silent = true;
  };

  home.ifEnabled.programs.ghostty = {
    enable = true;

    settings = {
      cursor-invert-fg-bg = true;
      theme = "catppuccin-macchiato";
      window-decoration = "none";
    };
  };

  home.ifEnabled.programs.fish = {
    enable = true;

    functions = {
      # Disable "Welcome to fish" message
      fish_greeting = "";
    };
  };
}
