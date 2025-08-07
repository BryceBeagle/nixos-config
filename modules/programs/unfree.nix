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

  nixos.always = {cfg, ...}: {
    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) cfg.allowUnfree;
  };
}
