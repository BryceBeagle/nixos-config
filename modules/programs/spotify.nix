{
  delib,
  inputs,
  pkgs,
  ...
}:
delib.module {
  name = "programs.spotify";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled = {
    impermanence.user.directories = [
      # Spotify API token stored here (in a file called `prefs`), but it recreates
      # the file every time.
      ".config/spotify/"
    ];

    programs.unfree.allowUnfree = ["spotify"];
  };

  home.always.imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  home.ifEnabled.programs.spicetify = {
    enable = true;

    theme = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}.themes.catppuccin;
  };
}
