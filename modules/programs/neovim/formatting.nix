{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.neovim";

  home.ifEnabled.programs.nixvim = {
    plugins = {
      conform-nvim = {
        enable = true;

        settings = {
          formatters_by_ft = {
            nix = ["alejandra"];
            rust = ["rustfmt"];
            _ = [
              "trim_newlines"
              "trim_whitespace"
            ];
          };

          formatters = {
            alejandra.command = lib.getExe pkgs.alejandra;
            rustfmt.command = lib.getExe pkgs.rustfmt;
          };

          format_on_save = {
            timeout_ms = 500;
          };
        };
      };
    };
  };
}
