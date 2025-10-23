{
  delib,
  lib,
  ...
}:
delib.module {
  name = "programs.unfree";

  options.programs.unfree = with delib; {
    allowUnfree = listOfOption str [];
  };

  # This is unused on NixOS and nix-darwin which have `useGlobalPackages`
  # enabled. But on machines with only home-manager, this is used.
  home.always = {cfg, ...}: {
    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) cfg.allowUnfree;
  };

  nixos.always = {cfg, ...}: {
    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) cfg.allowUnfree;
  };

  darwin.always = {cfg, ...}: {
    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) cfg.allowUnfree;
  };
}
