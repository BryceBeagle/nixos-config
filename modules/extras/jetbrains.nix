{delib, ...}:
delib.module {
  name = "extras.jetbrains";

  options = delib.singleEnableOption false;

  # Ideally this would be installed via `home-manager` but there are issues with
  # nix-darwin and GUI programs.
  # https://github.com/BryceBeagle/nixos-config/issues/245
  darwin.ifEnabled.homebrew.casks = ["intellij-idea"];
}
