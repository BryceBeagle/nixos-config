{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  home.persistence."/persist/home/ignormies" = {
    directories = [
      # Spotify API token stored here (in a file called `prefs`), but it recreates
      # the file every time.
      ".config/spotify/"
    ];
  };

  programs.spicetify = {
    enable = true;

    theme = inputs.spicetify-nix.legacyPackages.${pkgs.system}.themes.catppuccin;
  };
}
