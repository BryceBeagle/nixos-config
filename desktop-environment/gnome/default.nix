{ inputs, lib, pkgs, ... }: {
  imports = [
    ./just-perfection.nix
  ];

  home.packages = with pkgs.gnomeExtensions; [
    paperwm
  ];

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
      delay = (mkUint32 300);
      repeat-interval = (mkUint32 15);
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      natural-scroll = false;
    };
    "org/gnome/settings-daemon/plugins/power" = {
      # Disable automatic screen brightness
      ambient-enabled = false;
    };
    "org/gnome/shell" = {
      enabled-extensions = with pkgs.gnomeExtensions; [ 
        paperwm.extensionUuid
      ];
    };
    "org/gnome/shell/extensions/paperwm" = {
      show-window-position-bar = false;
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

