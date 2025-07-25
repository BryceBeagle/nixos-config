{ lib, pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      conform-nvim = {
        enable = true;

        settings = {
          formatters_by_ft = {
            nix = [ "nixfmt" ];
            rust = [ "rustfmt" ];
          };

          formatters = {
            nixfmt.command = lib.getExe pkgs.nixfmt-rfc-style;
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
