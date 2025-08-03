{
  delib,
  inputs,
  ...
}:
delib.module {
  name = "home-manager";

  options = delib.singleEnableOption true;

  nixos.always.imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  # This does not use `home.ifEnabled` as that is per-user, but this is configuring
  # `home-manager` itself
  #
  # https://discourse.nixos.org/t/34506
  nixos.ifEnabled.home-manager.useGlobalPkgs = true;

  home.ifEnabled.programs.home-manager.enable = true;
}
