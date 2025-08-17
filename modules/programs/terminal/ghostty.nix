{delib, ...}:
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
      theme = "catppuccin-macchiato";
      window-decoration = "none";
    };
  };
}
