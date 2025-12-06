{
  delib,
  pkgs,
  ...
}: let
  terminalPrograms = with pkgs; [
    cargo
    curl
    dive
    erdtree
    jq
    just
    ripgrep
    rustc
    tree
    unzip
    usbutils
    wget
  ];
in
  delib.module {
    name = "programs.terminal";

    options = delib.singleEnableOption true;

    # Default terminal configuration for other users
    nixos.ifEnabled = {
      # TTY font
      console.font = "Lat2-Terminus16";

      # Other assorted, globally installed packages
      environment.systemPackages = terminalPrograms;
    };

    # Other assorted, globally installed packages
    darwin.ifEnabled.environment.systemPackages = terminalPrograms;
  }
