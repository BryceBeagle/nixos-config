{ pkgs, ... }: {
  home.packages = with pkgs.gnomeExtensions; [
    paperwm
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = with pkgs.gnomeExtensions; [
        paperwm.extensionUuid
      ];
    };
    "org/gnome/shell/extensions/paperwm" = {
      show-window-position-bar = false;
    };
  };

  # Empty config file for now. Will populate in the future.
  # Having the empty file prevents `paperwm` from displaying a startup message
  # about creating the config dir.
  xdg.configFile."paperwm/user.css".text = "";
}
