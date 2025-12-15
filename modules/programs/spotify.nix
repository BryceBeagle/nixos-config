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

  darwin.ifEnabled = {
    # Spotify doesn't provide a stable URL and it's currently broken
    # https://github.com/NixOS/nixpkgs/issues/465676
    nixpkgs.overlays = [
      (final: prev: {
        spotify = prev.spotify.overrideAttrs (oldAttrs: {
          src = prev.fetchurl {
            url = "https://web.archive.org/web/20251029235406/https://download.scdn.co/SpotifyARM64.dmg";
            hash = "sha256-0gwoptqLBJBM0qJQ+dGAZdCD6WXzDJEs0BfOxz7f2nQ=";
          };
        });
      })
    ];
  };

  home.always.imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  home.ifEnabled.programs.spicetify = {
    enable = true;

    theme = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}.themes.catppuccin;
  };
}
