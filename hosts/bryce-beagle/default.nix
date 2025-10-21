{delib, ...}:
delib.host {
  name = "bryce-beagle";

  home.home = {
    stateVersion = "25.05";

    # TODO: This should read from myconfig.user.username
    homeDirectory = "/home/bits/";
    username = "bits";
  };

  homeManagerSystem = "x86_64-linux";
  # Overrides homeManagerUser set in flake.nix
  homeManagerUser = "bits";

  myconfig = {
    user.username = "bits";
  };
}
