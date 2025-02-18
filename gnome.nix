{ inputs, lib, pkgs, ... }: {
  dconf.settings = with lib.hm.gvariant; {
    "org/gnome/desktop/input-sources" = {
      sources = [ (mkTuple [ "xkb" "us" ]) ];

      # Do not set xkb-options here. They will shadow the xserver.xkb.options config
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
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
      enabled-extensions = [ pkgs.gnomeExtensions.paperwm.extensionUuid ];
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

