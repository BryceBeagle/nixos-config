{ ... }: {
  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;

        settings.incremental_selection = {
          enable = true;

          keymaps = {
            node_incremental = "v";
            node_decremental = "V";
          };
        };
      };
    };
  };
}
