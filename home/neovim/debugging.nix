{...}: {
  programs.nixvim = {
    plugins = {
      dap-python.enable = true;
      dap-ui = {
        enable = true;

        settings = {
          element_mappings = {
            stacks = {
              open = "<CR>";
              expand = "o";
            };
          };
        };

        luaConfig.post = ''
          local dap, dapui = require("dap"), require("dapui")
          dap.listeners.before.attach.dapui_config = function()
            dapui.open()
          end
          dap.listeners.before.launch.dapui_config = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
          end
          dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
          end
        '';
      };

      dap = {
        enable = true;

        signs = {
          dapBreakpoint = {
            text = "";
            texthl = "DapBreakpoint";
          };
          dapBreakpointRejected = {
            text = "󰅙";
            texthl = "DapBreakpointRejected";
          };
          dapStopped = {
            text = "";
            texthl = "DapStopped";
          };
        };
      };
    };
  };
}
