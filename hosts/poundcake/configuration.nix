{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../home
  ];

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
}
