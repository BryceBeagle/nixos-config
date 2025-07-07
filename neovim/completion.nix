{ ... }: {
  programs.nixvim = {
    plugins = {
      cmp-nvim-lsp.enable = true;

      cmp = {
        enable = true;

        autoEnableSources = true;

        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
          ];

          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";  # Start autocompletion
            "<C-e>" = "cmp.mapping.abort()";
            "<C-n>" = "cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select })";
            "<C-p>" = "cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select })";
            "<CR>" = "cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert })";
            "<Tab>" = "cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })";
          };
        };
      };

      lsp = {
        enable = true;

        inlayHints = true;

        keymaps = {
          silent = true;
          lspBuf = {
            K = "hover";
          };
        };

        servers = {
          nil_ls.enable = true;
          pyright.enable = true;
          ruff.enable = true;

          rust_analyzer = {
            enable = true;

            # Use system-installed packages
            installRustc = false;
            installCargo = false;
          };
        };
      };
    };
  };
}
