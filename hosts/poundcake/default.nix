{inputs, ...}: {
  imports = [
    inputs.nixos-hardware.nixosModules.framework-16-7040-amd

    ./hardware-configuration.nix
    ./configuration.nix
  ];
}
