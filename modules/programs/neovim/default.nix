{
  delib,
  inputs,
  pkgs,
  ...
}:
delib.module {
  name = "programs.neovim";

  options = delib.singleEnableOption true;

  home.always.imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  # Make neovim available to all users
  nixos.ifEnabled.programs.neovim = {
    enable = true;

    defaultEditor = true;
  };

  home.ifEnabled.programs.nixvim = {
    enable = true;

    nixpkgs.useGlobalPackages = true;

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
      direnv.enable = true;
      lualine.enable = true;
      noice.enable = true;
      nvim-autopairs.enable = true;
    };

    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "tiny-inline-diagnostic";
        src = builtins.fetchGit {
          url = "https://github.com/rachartier/tiny-inline-diagnostic.nvim";
          rev = "cd401038de4cbae37651cfe02510294ccf5cdc98";
        };
      })
    ];

    extraConfigLuaPost = ''
      require("tiny-inline-diagnostic").setup()
    '';
  };
}
