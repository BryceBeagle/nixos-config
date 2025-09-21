{delib, ...}:
delib.module {
  name = "desktop-environment.xdg";

  options.desktop-environment.xdg = with delib; {
    enable = boolOption true;

    defaultApplications = {
      pdf = listOfOption str [];
    };
  };

  home.ifEnabled = {cfg, ...}: {
    xdg = {
      enable = true;

      mimeApps = {
        enable = true;

        defaultApplications = {
          "application/pdf" = cfg.defaultApplications.pdf;
        };
      };
    };
  };
}
