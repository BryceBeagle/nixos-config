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

  home.ifEnabled = {
    programs = {
      dank-material-shell = {
        enable = true;

        systemd.enable = true;
      };
    };

    # Marker file telling DankMaterialShell the current changelog has been read
    home.file.".config/DankMaterialShell/.changelog-1.4".text = "";
  };
}
