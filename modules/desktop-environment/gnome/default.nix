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

  home.ifEnabled.dconf.settings = with inputs.home-manager.lib.hm.gvariant; {
    "org/gnome/desktop/input-sources" = {
      sources = [(mkTuple ["xkb" "us"])];

      # This duplicates the config in `xserver.xkb.options` due to (I think) an
      # upstream bug:
      # https://github.com/BryceBeagle/nixos-config/issues/163
      # https://discourse.nixos.org/t/suddenly-setting-caps-escape-in-xkb-settings-does-not-work-anymore/64714/6
      xkb-options = [
        "compose:ralt"
        "ctrl:nocaps"
      ];
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
      text-scaling-factor = 1.25;
    };
    "org/gnome/desktop/peripherals/keyboard" = {
      delay = mkUint32 300;
      repeat-interval = mkUint32 15;
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
  };

  home.ifEnabled.gtk = {
    enable = true;

    theme = let
      # TODO: Move this `colorSchemes` attr to a higher scope
      colorScheme = inputs.nix-colors.colorSchemes.catppuccin-macchiato;
    in {
      name = colorScheme.slug;
      package = (inputs.nix-colors.lib-contrib {inherit pkgs;}).gtkThemeFromScheme {scheme = colorScheme;};
    };
  };
}
