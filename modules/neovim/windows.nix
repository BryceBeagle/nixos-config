{delib, ...}:
delib.module {
  name = "neovim";

  home.ifEnabled.programs.nixvim = {
    opts = {
      # Open new splits to the right instead of to the left
      splitright = true;
    };

    plugins = {
      auto-session = {
        enable = true;

        autoLoad = true;
      };
    };
  };
}
