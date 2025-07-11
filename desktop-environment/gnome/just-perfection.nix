{ pkgs, ... }: {
  home.packages = with pkgs.gnomeExtensions; [
    just-perfection
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = with pkgs.gnomeExtensions; [
        just-perfection.extensionUuid
      ];
    };

    "org/gnome/shell/extensions/just-perfection" = {
      panel = false;
      panel-in-overview = true;

      # Start to desktop instead of overview
      startup-status = 1;
      # Disable the prompt to donate (I did!)
      support-notifier-type = 0;

      accessibility-menu = false;
      # What MacOS calls the Dock
      dash = false;
      # 'Events' in the clock menu
      events = false;
      # Hides search bar visually, but can still type to start searching
      search = false;
      weather = false;
      # Little icon under the window preview in overview
      window-picker-icon = false;
      window-preview-caption = false;
      # Workspace indicator in overview
      workspace = false;
    };
  };
}
