{delib, ...}:
delib.module {
  name = "programs.neovim";

  home.ifEnabled.programs.nixvim = {
    plugins = {
      neotest = {
        enable = true;

        adapters = {
          python = {
            enable = true;

            settings = {
              dap.justMyCode = false;
              runner = "pytest";
            };
          };
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>ta";
        action = ":lua require('neotest').run.run(vim.loop.cwd())<CR>";
        options = {
          desc = "Test all";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>tf";
        action = ":lua require('neotest').run.run(vim.fn.expand '%:.')<CR>";
        options = {
          desc = "Test file";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>tn";
        action = "<cmd>lua require('neotest').run.run()<CR>";
        options = {
          desc = "Test nearest";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>td";
        action = "<cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>";
        options = {
          desc = "Test nearest (debug)";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>tx";
        action = "<cmd>lua require('neotest').run.stop()<CR>";
        options = {
          desc = "Kill tests";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>to";
        action = "<cmd>lua require('neotest').output_panel.toggle()<CR>";
        options = {
          desc = "Toggle test output panel";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>ts";
        action = "<cmd>lua require('neotest').summary.toggle()<CR>";
        options = {
          desc = "Toggle test summary panel";
          silent = true;
        };
      }
    ];
  };
}
