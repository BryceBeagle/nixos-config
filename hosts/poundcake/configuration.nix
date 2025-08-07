{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../home
  ];

  # Persist some system directories
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      # Backlight value(s) from previous boot. The files in here are written at
      # poweroff and read at startup.
      # We could consider forcing a value into the file(s) instead of persisting
      # the previous boot's state.
      "/var/lib/systemd/backlight/"
    ];
  };

  # Globally enabled for all users
  environment.systemPackages = with pkgs; [
    # CLI tools
    # Useful for LSPs and other file-editing
    cargo
    rust-analyzer
  ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "discord"
      "spotify"
    ];

  programs.git.enable = true;
}
