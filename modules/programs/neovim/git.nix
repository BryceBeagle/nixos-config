{delib, ...}:
delib.module {
  name = "programs.neovim";

  home.ifEnabled.programs.nixvim = {
    plugins = {
      diffview.enable = true;
      gitgutter.enable = true;

      gitlinker = {
        enable = true;

        actionCallback = "open_in_browser";
      };
    };
  };
}
