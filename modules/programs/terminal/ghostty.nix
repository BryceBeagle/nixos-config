{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.terminal.ghostty";

  options = delib.singleEnableOption true;

  home.ifEnabled.programs.ghostty = {
    enable = true;

    # The main ghostty package is marked as broken on darwin
    # https://github.com/NixOS/nixpkgs/issues/388984
    # https://github.com/NixOS/nixpkgs/pull/405449
    package = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin pkgs.ghostty-bin;

    settings = {
      cursor-invert-fg-bg = true;
      theme = "Catppuccin Macchiato";

      # TODO: denix doesn't provide a way to do linux- or darwin-only home config
      # TODO: Also, consider moving this to desktop-environment settings
      window-decoration = lib.mkIf pkgs.stdenv.hostPlatform.isLinux "none";
      macos-titlebar-style = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin "hidden";

      # Default true on Linux, false on MacOS
      # We want it always off
      quit-after-last-window-closed = true;

      # Support SSH terminals that do not know about ghostty
      # https://ghostty.org/docs/help/terminfo
      shell-integration-features = "ssh-terminfo";
    };
  };
}
