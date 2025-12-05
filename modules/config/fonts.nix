{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "fonts";

  # fontconfig must be enabled in home-manager config for these to be used
  nixos.always.fonts.packages = with pkgs; [
    noto-fonts
    nerd-fonts.jetbrains-mono
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];

  # From https://wiki.nixos.org/wiki/Fonts:
  # > Nix inserts its user profile path into $XDG_DATA_DIRS, which Fontconfig by
  # > default doesn't look in. This cause graphical applications like KDE Plasma not
  # > able to recognize the fonts installed via nix-env or nix profile.
  home.always.fonts.fontconfig.enable = true;
}
