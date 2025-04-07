{ ... }: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    opts = {
      # Tabs/spaces
      number = true;  # Show line numbers
      tabstop = 4;  # 4 space tabs
      expandtab = true;  # <Tab> turns into spaces
      shiftwidth = 4;  # Shift+< and Shift+> indent 4 spaces

      # Navigation
      scrolloff = 999;  # ~Hack to keep cursor always at center of window
      relativenumber = true;  # Use relative line numbers in gutter

      shell = "fish";
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader><C-e>";
        action = ":Neotree buffers reveal float<CR>";
      }
      {
        mode = "n";
        key = "<leader><C-o>";
        action = ":Neotree filesystem toggle float<CR>";
      }
    ];

    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "macchiato";
    };

    plugins = {
      cmp-nvim-lsp.enable = true;
      diffview.enable = true;
      web-devicons.enable = true;  # Used by neo-tree
      treesitter.enable = true;

      cmp = {
        enable = true;

        autoEnableSources = true;

        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
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

          rust_analyzer = {
            enable = true;

            # Use system-install packages
            installRustc = false;
            installCargo = false;
          };
        };
      };
      neo-tree = {
        enable = true;

        closeIfLastWindow = true;
        popupBorderStyle = "rounded";
      };
      telescope = {
        enable = true;

        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
        };
      };
    };
  };
}
