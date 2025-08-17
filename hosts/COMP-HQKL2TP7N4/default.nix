{delib, ...}:
delib.host {
  # Ugly hostname controlled by workplace
  name = "COMP-HQKL2TP7N4";

  # NixOS uses "YY.MM" strings, but nix-darwin uses auto-incrementing integers
  darwin.system.stateVersion = 6;
  darwin.nixpkgs.hostPlatform = "aarch64-darwin";
  home.home.stateVersion = "25.05";

  # Overrides homeManagerUser set in flake.nix
  homeManagerUser = "bryce.beagle";

  myconfig = {
    user.username = "bryce.beagle";

    desktop-environment.macos.enable = true;

    programs.homebrew.enable = true;

    projects.bazel.enable = true;
  };
}
