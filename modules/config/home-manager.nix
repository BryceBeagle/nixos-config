{
  delib,
  inputs,
  pkgs,
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
  darwin.ifEnabled.home-manager.useGlobalPkgs = true;

  home.ifEnabled = {
    programs.home-manager.enable = true;

    # Copy apps to ~/Applications for indexing by Spotlight
    # https://github.com/NixOS/nixpkgs/issues/388984
    # https://github.com/NixOS/nixpkgs/pull/405449
    #
    # This becomes the default with systemVersion >= 25.11
    targets.darwin.copyApps.enable = pkgs.stdenv.hostPlatform.isDarwin;
    targets.darwin.linkApps.enable = false;
  };
}
