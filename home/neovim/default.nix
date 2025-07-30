{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim

    ./completion.nix
    ./debugging.nix
    ./formatting.nix
    ./navigation.nix
    ./selection.nix
    ./terminal.nix
    ./testing.nix
    ./windows.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    globals = {
      # https://learnvimscriptthehardway.stevelosh.com/chapters/06.html
      mapleader = " ";
    };
    opts = {
      # Tabs/spaces
      number = true; # Show line numbers
      tabstop = 4; # 4 space tabs
      expandtab = true; # <Tab> turns into spaces
      shiftwidth = 4; # Shift+< and Shift+> indent 4 spaces

      shell = "fish";
    };

    keymaps = [
      {
        mode = "i";
        key = "jj";
        action = "<Esc>";
      }
    ];

    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "macchiato";
    };

    plugins = {
      diffview.enable = true;
      direnv.enable = true;
      gitgutter.enable = true;
      lualine.enable = true;
      noice.enable = true;
      nvim-autopairs.enable = true;
      web-devicons.enable = true; # Used by neo-tree
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
      (pkgs.vimUtils.buildVimPlugin {
        name = "tiny-inline-diagnostic";
        src = builtins.fetchGit {
          url = "https://github.com/rachartier/tiny-inline-diagnostic.nvim";
          rev = "cd401038de4cbae37651cfe02510294ccf5cdc98";
        };
      })
    ];

    extraConfigLuaPost = ''
      require("claude-code").setup()
      require("tiny-inline-diagnostic").setup()
    '';
  };
}
