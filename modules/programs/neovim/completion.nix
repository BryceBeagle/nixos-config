{
  delib,
  inputs,
  ...
}:
delib.module {
  name = "programs.neovim";

  home.ifEnabled.programs.nixvim = {
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
              columns = inputs.nixvim.lib.nixvim.utils.mkRaw ''
                { { "kind_icon" }, { "label", gap = 1 } }
              '';
              components = {
                label = {
                  text = inputs.nixvim.lib.nixvim.utils.mkRaw ''
                    require("colorful-menu").blink_components_text
                  '';
                  highlight = inputs.nixvim.lib.nixvim.utils.mkRaw ''
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
          bashls.enable = true;
          pyright.enable = true;
          ruff.enable = true;

          nixd = {
            enable = true;

            # https://github.com/nix-community/nixd/blob/main/nixd/docs/configuration.md
            settings = let
              flake = ''(builtins.getFlake (builtins.toString ./.))'';
              system = ''''${builtins.currentSystem}'';
            in {
              nixpkgs.expr = "import ${flake}.inputs.nixpkgs {}";

              options = {
                nixos.expr = ''${flake}.nixosConfigurations.poundcake.options'';
                # This does not work for some reason:
                # https://github.com/nix-community/nixd/issues/706
                nixvim.expr = ''${flake}.inputs.nixvim.nixvimConfigurations.${system}.default.options'';
              };
            };
          };
        };
      };

      rustaceanvim = {
        enable = true;

        settings = {
          # https://rust-analyzer.github.io/book/configuration
          # https://github.com/rust-lang/rust-analyzer/blob/master/editors/code/package.json
          server.default_settings.rust_analyzer = {
            check.command = "clippy";
            inlayHints = {
              closureCaptureHints.enable = true;
              closureReturnTypeHints.enable = "with_block";
              discriminantHints.enable = "fieldless";
              lifetimeElisionHints.enable = "skip_trivial";
              renderColons = false;
            };
          };
        };
      };
    };
  };
}
