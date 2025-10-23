{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.terminal.ghostty";

  options = delib.singleEnableOption true;

  darwin.ifEnabled = {myconfig, ...}: {
    # ghostty is marked as broken on darwin. We have to install it with homebrew.
    # The home-manager config will still apply.
    # https://github.com/NixOS/nixpkgs/issues/388984
    homebrew.casks = ["ghostty"];
    home-manager.users.${myconfig.user.username}.programs.ghostty.package = null;
  };

  home.ifEnabled.programs.ghostty = {
    enable = true;

    settings = {
      cursor-invert-fg-bg = true;
      theme = "Catppuccin Macchiato";

      # TODO: denix doesn't provide a way to do linux- or darwin-only home config
      # TODO: Also, consider moving this to desktop-environment settings
      window-decoration = lib.mkIf pkgs.stdenv.isLinux "none";
      macos-titlebar-style = lib.mkIf pkgs.stdenv.isDarwin "hidden";

      # Support SSH terminals that do not know about ghostty
      # https://ghostty.org/docs/help/terminfo
      shell-integration-features = "ssh-terminfo";
    };
  };
}
