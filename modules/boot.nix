{delib, ...}:
delib.module {
  name = "boot";

  nixos.always = {
    # Use systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
