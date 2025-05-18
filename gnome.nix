{ inputs, lib, pkgs, ... }: {
  dconf.settings = with lib.hm.gvariant; {
    "org/gnome/desktop/input-sources" = {
      sources = [ (mkTuple [ "xkb" "us" ]) ];

      # Do not set xkb-options here. They will shadow the xserver.xkb.options config
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
      text-scaling-factor = 1.25;
    };
    "org/gnome/desktop/peripherals/keyboard" = {
      delay = 150;
      repeat-interval = 15;
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      natural-scroll = false;
    };
    "org/gnome/shell" = {
      # Installed above in systemPackages. Ideally this becomes more isolated when we
      # split into multiple modules
      enabled-extensions = with pkgs.gnomeExtensions; [ 
        just-perfection.extensionUuid
        paperwm.extensionUuid
      ];
    };
    "org/gnome/shell/extensions/just-perfection" = {
      panel = false;
      panel-in-overview = true;

      # Start to desktop instead of overview
      startup-status = 1;

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
      workspace-switcher-should-show = false;
    };
  };

  gtk = {
    enable = true;

    theme = let
      # TODO: Move this `colorSchemes` attr to a higher scope
      colorScheme = inputs.nix-colors.colorSchemes.catppuccin-macchiato;
    in {
      name = colorScheme.slug;
      package = (inputs.nix-colors.lib-contrib { inherit pkgs; }).gtkThemeFromScheme { scheme = colorScheme; };
    };
  };
}

