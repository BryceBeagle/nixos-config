{delib, ...}:
delib.module {
  name = "programs.neovim";

  myconfig.ifEnabled = {
    impermanence.user.directories = [
      # Persist undo history (this is the default ':h undodir' location)
      ".local/state/nvim/undo/"
    ];
  };

  home.ifEnabled.programs.nixvim = {
    opts = {
      # Save history to disk so that it persists between sessions
      # Defaults to $XDG_STATE_HOME/nvim/undo/ on Linux
      undofile = true;
    };
  };
}
