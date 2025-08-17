{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.terminal";

  options = delib.singleEnableOption true;

  # Default terminal configuration for other users
  nixos.ifEnabled = {
    # TTY font
    console.font = "Lat2-Terminus16";

    # Other assorted, globally installed packages
    environment.systemPackages = with pkgs; [
      curl
      jq
      just
      libinput
      ripgrep
      tree
      unzip
      usbutils
      wget
    ];
  };
}
