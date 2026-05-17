{
  delib,
  inputs,
  ...
}:
delib.module {
  name = "desktop-environment.niri";

  home.always.imports = [
    inputs.dank-material-shell.homeModules.dank-material-shell
  ];

  home.ifEnabled.programs = {
    dank-material-shell = {
      enable = true;

      systemd.enable = true;
    };
  };
}
