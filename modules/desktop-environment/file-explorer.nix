{
  delib,
  lib,
  ...
}:
delib.module {
  name = "desktop-environment.file-explorer";

  options = delib.singleEnableOption true;

  darwin.ifEnabled.system.defaults = {
    finder = {
      ShowPathbar = true;
    };
  };

  home.ifEnabled = {myconfig, ...}:
    lib.mkIf myconfig.desktop-environment.gnome.enable {
      # These appear in the sidebar of GTK file explorer applications such as nautilus.
      # Note that setting this removes the default bookmarks, but I don't really care
      # about those.
      gtk.gtk3.bookmarks = [
        "file:///tmp"
      ];

      dconf.settings = {
        "org/gnome/nautilus/preferences" = {
          default-folder-viewer = "list-view";
        };
      };
    };
}
