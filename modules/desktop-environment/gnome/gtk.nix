{
  delib,
  inputs,
  pkgs,
  ...
}:
delib.module {
  name = "desktop-environment.gnome";

  home.always.imports = [
    inputs.nix-colors.homeManagerModules.default
  ];

  home.ifEnabled = {
    gtk = {
      enable = true;

      theme = let
        # TODO: Move this `colorSchemes` attr to a higher scope
        colorScheme = inputs.nix-colors.colorSchemes.catppuccin-macchiato;
      in {
        name = colorScheme.slug;
        package = (
          inputs.nix-colors.lib-contrib {pkgs = pkgs;}
        ).gtkThemeFromScheme {scheme = colorScheme;};
      };
    };
  };
}
