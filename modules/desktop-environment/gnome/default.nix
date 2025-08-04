{
  delib,
  inputs,
  pkgs,
  ...
}:
delib.module {
  name = "desktop-environment.gnome";

  options = delib.singleEnableOption false;

  home.always.imports = [
    inputs.nix-colors.homeManagerModules.default
  ];

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

  home.ifEnabled = {
    dconf.settings = with inputs.home-manager.lib.hm.gvariant; {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        enable-hot-corners = false;
        text-scaling-factor = 1.25;
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
    };

    gtk = {
      enable = true;

      theme = let
        # TODO: Move this `colorSchemes` attr to a higher scope
        colorScheme = inputs.nix-colors.colorSchemes.catppuccin-macchiato;
      in {
        name = colorScheme.slug;
        package = (inputs.nix-colors.lib-contrib {inherit pkgs;}).gtkThemeFromScheme {scheme = colorScheme;};
      };
    };
  };
}
