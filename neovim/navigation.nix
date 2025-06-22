{ ... }: {
  programs.nixvim = {

    opts = {
      foldlevelstart = 999;  # ~Hack to keep things unfolded on file open
      scrolloff = 999;  # ~Hack to keep cursor always at center of window
      relativenumber = true;  # Use relative line numbers in gutter
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
        mode = [ "n" "x" ];
        key = "s";
        action = ":lua require('flash').jump()<CR>";
        options.desc = "flash";
      }
      {
        mode = [ "n" "x" ];
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
  };
}
