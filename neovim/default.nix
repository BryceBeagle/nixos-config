{ pkgs, ... }: {
  imports = [
    ./debugging.nix
    ./testing.nix
  ];

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
        mode = "i";
        key = "jj";
        action = "<Esc>";
      }
      {
        mode = "t";
        key = "jj";
        action = "<C-\\><C-n>";
      }
      {
        mode = "n";
        key = "<leader><C-e>";
        action = ":Neotree buffers reveal float<CR>";
      }
      {
        mode = "n";
        key = "<leader><C-o>";
        action = ":Neotree filesystem toggle<CR>";
      }
    ];

    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "macchiato";
    };

    plugins = {
      cmp-nvim-lsp.enable = true;
      diffview.enable = true;
      direnv.enable = true;
      gitgutter.enable = true;
      lualine.enable = true;
      nvim-autopairs.enable = true;
      treesitter.enable = true;
      web-devicons.enable = true;  # Used by neo-tree

      auto-session = {
        enable = true;

        autoLoad = true;
      };
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
      neo-tree = {
        enable = true;

        closeIfLastWindow = true;
        popupBorderStyle = "rounded";

        extraOptions = {
          open_files_do_not_replace_types = [
            "terminal"
          ];
        };
      };
      telescope = {
        enable = true;

        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
        };
      };
    };

    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "claude-code-nvim";
        src = builtins.fetchGit {
          url = "https://github.com/greggh/claude-code.nvim";
          ref = "refs/tags/v0.4.3";
          rev = "d1dbc6b7025c4f034e14cc0dda6d29d5a6a5c4e8";
        };
      })
    ];

    extraConfigLuaPost = ''
      require("claude-code").setup()
    '';
  };
}
