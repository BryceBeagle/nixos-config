{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "theming";

  home.ifEnabled = {myconfig, ...}: {
    stylix = {
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";

      targets = {
        # Chooses a base16 theme by default, even though we can easily use a base24 theme
        nixvim.enable = false;

        # Has more limited colors
        # https://github.com/BryceBeagle/nixos-config/issues/336#issuecomment-4028988354
        ghostty.enable = false;
      };
    };

    programs = {
      ghostty = lib.mkIf myconfig.programs.terminal.ghostty.enable {
        settings.theme = "Catppuccin Macchiato";
      };

      nixvim = lib.mkIf myconfig.programs.neovim.enable {
        colorschemes.catppuccin = {
          enable = true;

          settings.flavour = "macchiato";
        };
      };
    };
  };
}
