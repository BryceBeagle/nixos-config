{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.neovim";

  home.ifEnabled.programs.nixvim = {
    opts = {
      foldlevelstart = 999; # ~Hack to keep things unfolded on file open
      scrolloff = 999; # ~Hack to keep cursor always at center of window
      relativenumber = true; # Use relative line numbers in gutter
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>gf";
        action = ":Neotree filesystem<CR>";
      }
      {
        mode = "n";
        key = "<leader>gb";
        action = ":Neotree buffers reveal float<CR>";
      }
      {
        mode = "n";
        key = "<leader>gtf";
        action = ":Neotree filesystem toggle<CR>";
      }
      {
        mode = ["n" "x"];
        key = "s";
        action = ":lua require('flash').jump()<CR>";
        options.desc = "flash";
      }
      {
        mode = ["n" "x"];
        key = "S";
        action = ":lua require('flash').treesitter()<CR>";
        options.desc = "flash Treesitter";
      }
    ];

    plugins = {
      dropbar.enable = true;
      flash.enable = true;
      neoscroll.enable = true;
      nvim-ufo.enable = true;
      web-devicons.enable = true; # Used by neo-tree

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
        extensions.fzf-native.enable = true;

        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
        };
      };
    };

    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "smear-cursor-nvim";
        src = builtins.fetchGit {
          url = "https://github.com/sphamba/smear-cursor.nvim";
          ref = "refs/tags/v0.4.7";
          rev = "aff844fc1483fd673f721a41affcd7e2fcb885f5";
        };
      })
    ];

    extraConfigLuaPost = ''
      require("smear_cursor").setup({
        -- Disable smearing in insert mode. Visually distracting; cursor moves less.
        smear_insert_mode = false,

        -- Increase head speed, reduce tail speed
        stiffness = 0.5,
        trailing_stiffness = 0.3,

        -- Always render smear, no matter the distance
        max_length = 999,

        -- Increase framerate
        time_interval = 7,

        -- Default smear color does not seems to respect actual cursor color
        -- (Likely related to change for https://github.com/BryceBeagle/nixos-config/issues/177)
        -- I also kinda like the red. Note that this does not appear as true red,
        -- (I guess because of theming?), and more as a pastel red.
        cursor_color = "#ff0000",

        -- Use better symbols
        legacy_computing_symbols_support = true,
        legacy_computing_symbols_support_vertical_bars = true,
      })
    '';
  };
}
