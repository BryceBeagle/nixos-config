{ inputs, lib, pkgs, ... }: {
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "spotify"
    ];

  programs.spicetify = {
    enable = true;

    theme = inputs.spicetify-nix.legacyPackages.${pkgs.system}.themes.catppuccin;
  };
}
