{ config, ... }: {
  programs.nixvim = {
    plugins = {
      colorful-menu.enable = true;

      blink-cmp = {
        enable = true;

        settings = {
          keymap.preset = "enter";

          completion = {
            ghost_text.enabled = true;

            # Consider full tokens even if cursor is in the center of one
            # https://cmp.saghen.dev/configuration/reference.html#completion-keyword
            keyword.range = "full";

            # Using default blink<->colorful-menu configuration as documented here:
            # https://github.com/xzbdmw/colorful-menu.nvim?tab=readme-ov-file#use-it-in-blinkcmp
            #
            # Ideally, there would be a dedicated option for this
            menu.draw = {
              columns = config.lib.nixvim.utils.mkRaw ''
                { { "kind_icon" }, { "label", gap = 1 } }
              '';
              components = {
                label = {
                  text = config.lib.nixvim.utils.mkRaw ''
                    require("colorful-menu").blink_components_text
                  '';
                  highlight = config.lib.nixvim.utils.mkRaw ''
                    require("colorful-menu").blink_components_highlight
                  '';
                };
              };
            };
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
