{ ... }: {
  programs.nixvim = {
    plugins = {
      blink-cmp = {
        enable = true;

        settings = {
          keymap.preset = "enter";

          completion = {
            ghost_text.enabled = true;

            # Consider full tokens even if cursor is in the center of one
            # https://cmp.saghen.dev/configuration/reference.html#completion-keyword
            keyword.range = "full";
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
