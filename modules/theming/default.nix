{
  delib,
  inputs,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "theming";

  options = delib.singleEnableOption true;

  home.always.imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  home.ifEnabled = {myconfig, ...}: {
    programs.ghostty = lib.mkIf myconfig.programs.terminal.ghostty.enable {
      settings.theme = "Catppuccin Macchiato";
    };

    programs.nixvim = lib.mkIf myconfig.programs.neovim.enable {
      colorschemes.catppuccin = {
        enable = true;

        settings.flavour = "macchiato";
      };
    };

    programs.spicetify = lib.mkIf myconfig.programs.spotify.enable {
      theme = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}.themes.catppuccin;
    };
  };
}
