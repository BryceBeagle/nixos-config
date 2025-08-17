{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "programs";

  # Globally enabled for all users
  nixos.always.environment.systemPackages = with pkgs; [
    # Useful for LSPs and other file-editing
    cargo
    rust-analyzer

    # TODO: Can probably delete this:
    # https://github.com/BryceBeagle/nixos-config/issues/259
    libinput
  ];

  home.always = {myconfig, ...}:
    lib.mkIf myconfig.desktop-environment.gnome.enable {
      home.packages = with pkgs; [
        loupe
        gedit
        baobab
        gnome-calculator
        gnome-screenshot
        gnome-system-monitor
        gnome-tweaks
        nautilus
      ];
    };
}
