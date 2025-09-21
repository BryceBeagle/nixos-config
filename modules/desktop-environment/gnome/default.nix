{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "desktop-environment.gnome";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    services = {
      desktopManager.gnome.enable = true;
      gnome.core-apps.enable = false;
    };

    environment.gnome.excludePackages = with pkgs; [
      gnome-shell-extensions
      gnome-tour
    ];
  };

  home.ifEnabled.dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
      text-scaling-factor = 1.25;
    };
    "org/gnome/settings-daemon/plugins/power" = {
      # Disable automatic screen brightness
      ambient-enabled = false;
    };
  };
}
