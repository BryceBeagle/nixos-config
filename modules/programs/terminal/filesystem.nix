{
  delib,
  lib,
  pkgs,
  ...
}: let
  terminalPrograms = with pkgs; [
    erdtree
    tree
  ];
in
  delib.module {
    name = "programs.terminal";

    nixos.ifEnabled = {
      environment.systemPackages = terminalPrograms;
    };

    # Other assorted, globally installed packages
    darwin.ifEnabled.environment.systemPackages = terminalPrograms;

    home.ifEnabled = {
      programs.eza.enable = true;

      home.shellAliases = {
        eza = "eza --icons --group-directories-first";
        ls = "eza";
      };
    };
  }
