{inputs, ...}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    # Implicitly passed to all modules under 'imports'. `inputs' is not a default
    # 'specialArg', so it needs to be listed.
    extraSpecialArgs = {inherit inputs;};

    # https://discourse.nixos.org/t/34506
    useGlobalPkgs = true;

    users.ignormies = {pkgs, ...}: {
      imports = [
        inputs.impermanence.homeManagerModules.impermanence
      ];

      programs.home-manager.enable = true;

      # From https://wiki.nixos.org/wiki/Fonts:
      # > Nix inserts its user profile path into $XDG_DATA_DIRS, which Fontconfig by
      # > default doesn't look in. This cause graphical applications like KDE Plasma not
      # > able to recognize the fonts installed via nix-env or nix profile.
      fonts.fontconfig.enable = true;

      # Globally enabled, even without flake
      home.packages = with pkgs; [
        # Gnome tools
        loupe
        gedit
        baobab
        gnome-calculator
        gnome-screenshot
        gnome-system-monitor
        gnome-tweaks
        nautilus
      ];

      home.persistence."/persist/home/ignormies" = {
        files = [
          # Exercism API token stored here
          ".config/exercism/user.json"
        ];
        allowOther = true;
      };
    };
  };
}
