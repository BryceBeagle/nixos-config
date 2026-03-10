{
  delib,
  lib,
  pkgs,
  ...
}: let
in
  delib.module {
    name = "programs.terminal";

    home.ifEnabled = {myconfig, ...}: {
      programs.fish = lib.mkIf myconfig.programs.terminal.fish.enable {
        functions = {
          # Always ls/eza after cd-ing.
          # Note: this uses the eza alias defined in ./filesystem.nix
          cd = {
            body = ''
              builtin cd $argv
              or return

              eza
            '';
            wraps = "cd";
          };
        };
      };
    };
  }
