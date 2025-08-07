{pkgs, ...}: {
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
}
