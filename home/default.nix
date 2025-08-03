{inputs, ...}: {
  home-manager = {
    # Implicitly passed to all modules under 'imports'. `inputs' is not a default
    # 'specialArg', so it needs to be listed.
    extraSpecialArgs = {inherit inputs;};

    users.ignormies = {pkgs, ...}: {
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
      };
    };
  };
}
