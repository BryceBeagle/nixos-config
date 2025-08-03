{
  delib,
  inputs,
  pkgs,
  ...
}:
delib.module {
  name = "spotify";

  options = delib.singleEnableOption false;

  home.always.imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  home.ifEnabled.home.persistence."/persist/home/ignormies" = {
    directories = [
      # Spotify API token stored here (in a file called `prefs`), but it recreates
      # the file every time.
      ".config/spotify/"
    ];
  };

  home.ifEnabled.programs.spicetify = {
    enable = true;

    theme = inputs.spicetify-nix.legacyPackages.${pkgs.system}.themes.catppuccin;
  };
}
