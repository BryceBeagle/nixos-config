{delib, ...}:
delib.module {
  name = "desktop-environment.macos";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {
    # homebrew must also be enabled in config for this to do anything
    # These are installed in homebrew instead of using home-manager/nixpkgs due to an
    # issue with nix-darwin.
    # See: https://github.com/BryceBeagle/nixos-config/issues/245
    homebrew.casks = [
      "alt-tab"
      "jordanbaird-ice"
    ];
  };
}
