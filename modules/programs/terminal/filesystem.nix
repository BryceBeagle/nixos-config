{
  delib,
  pkgs,
  ...
}: let
  terminalPrograms = with pkgs; [
    erdtree
    eza
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
  }
