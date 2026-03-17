{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "theming";

  home.ifEnabled = {
    stylix = {
      cursor = {
        name = "catppuccin-macchiato-dark-cursors";
        package = pkgs.catppuccin-cursors.macchiatoDark;
        size = 32;
      };
    };
  };
}
