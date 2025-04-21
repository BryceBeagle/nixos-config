{ pkgs, ... }: {
  imports = [
    ./debugging.nix
    ./navigation.nix
    ./selection.nix
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
      noice.enable = true;
      nvim-autopairs.enable = true;
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
