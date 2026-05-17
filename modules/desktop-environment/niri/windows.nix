{delib, ...}:
delib.module {
  name = "desktop-environment.niri";

  home.ifEnabled.programs.niri = {
    settings = {
      layout = {
        default-column-width.proportion = 1. / 3;
      };

      workspaces = {
        media = {
          # TODO: Default to specific monitor in multi-monitor desk configuration
        };
      };

      window-rules = [
        {
          matches = [{app-id = "spotify";}];
          default-column-width.proportion = 1.;

          open-on-workspace = "media";
        }
      ];
    };
  };
}
