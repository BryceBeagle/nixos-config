{
  delib,
  inputs,
  ...
}:
delib.module {
  name = "pre-denix";

  nixos.always.imports = [
    inputs.nixos-hardware.nixosModules.framework-16-7040-amd

    ../hosts/poundcake/hardware-configuration.nix
  ];
}
