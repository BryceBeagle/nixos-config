{
  config,
  delib,
  lib,
  ...
}:
delib.module {
  name = "desktop-environment.gdm";

  options = with delib;
    moduleOptions ({parent, ...}: {
      enable = boolOption parent.enable;

      # Allow the user to customize which desktop environment / session type
      # is the default.
      #
      # If there are:
      # - O/1 options available: no default, but also not required
      # - 2+ options available: required to be assigned
      defaultSession = with {
        sessionNames = config.services.displayManager.sessionData.sessionNames;
      };
        if builtins.length sessionNames < 2
        then allowNull (strOption null)
        else enumOption sessionNames null;
    });

  nixos.ifEnabled = {cfg, ...}: {
    services.displayManager = {
      defaultSession = cfg.defaultSession;
      gdm.enable = true;
    };
  };
}
