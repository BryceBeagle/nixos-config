{delib, ...}:
delib.module {
  name = "programs.neovim";

  home.ifEnabled.programs.nixvim = {
    plugins = {
      render-markdown.enable = true;

      lsp.servers.marksman.enable = true;
    };
  };
}
