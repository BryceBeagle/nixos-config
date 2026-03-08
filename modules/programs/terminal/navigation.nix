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
          cd = {
            body = ''
              builtin cd $argv
              ${lib.getExe pkgs.eza} --icons --group-directories-first
            '';
            wraps = "cd";
          };
        };
      };
    };
  }
