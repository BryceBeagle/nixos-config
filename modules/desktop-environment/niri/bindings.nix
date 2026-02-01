{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "desktop-environment.niri";

  home.ifEnabled.programs.niri = {
    settings = {
      binds = {
        # Defaults:
        # https://github.com/YaLTeR/niri/blob/v25.11/resources/default-config.kdl#L349

        # Actions
        "Mod+Shift+Slash".action.show-hotkey-overlay = {};
        "Ctrl+Alt+Delete".action.quit = {};
        "Print".action.screenshot = {};
        "Ctrl+Print".action.screenshot-screen = {};
        "Alt+Print".action.screenshot-window = {};
        "Mod+Shift+P".action.power-off-monitors = {};
        "Mod+O" = {
          action.toggle-overview = {};
          repeat = false;
        };

        # Programs
        "Mod+T" = {
          action.spawn = lib.getExe pkgs.ghostty;
          hotkey-overlay.title = "Terminal";
          repeat = false;
        };
        "Mod+Space" = {
          action.spawn = [(lib.getExe pkgs.vicinae) "toggle"];
          hotkey-overlay.title = "App Launcher";
          repeat = false;
        };

        # Change focus within a workspace
        "Mod+Left".action.focus-column-left = {};
        "Mod+Down".action.focus-window-down = {};
        "Mod+Up".action.focus-window-up = {};
        "Mod+Right".action.focus-column-right = {};
        "Mod+H".action.focus-column-left = {};
        "Mod+J".action.focus-window-down = {};
        "Mod+K".action.focus-window-up = {};
        "Mod+L".action.focus-column-right = {};
        "Mod+Home".action.focus-column-first = {};
        "Mod+End".action.focus-column-last = {};

        # Change focus between monitors
        "Mod+Shift+Left".action.focus-monitor-left = {};
        "Mod+Shift+Down".action.focus-monitor-down = {};
        "Mod+Shift+Up".action.focus-monitor-up = {};
        "Mod+Shift+Right".action.focus-monitor-right = {};
        "Mod+Shift+H".action.focus-monitor-left = {};
        "Mod+Shift+J".action.focus-monitor-down = {};
        "Mod+Shift+K".action.focus-monitor-up = {};
        "Mod+Shift+L".action.focus-monitor-right = {};

        # Change focus between workspaces
        "Mod+Page_Down".action.focus-workspace-down = {};
        "Mod+Page_Up".action.focus-workspace-up = {};
        "Mod+U".action.focus-workspace-down = {};
        "Mod+I".action.focus-workspace-up = {};
        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;

        # Move windows between columns
        "Mod+BracketLeft".action.consume-or-expel-window-left = {};
        "Mod+BracketRight".action.consume-or-expel-window-right = {};
        "Mod+Comma".action.consume-window-into-column = {};
        "Mod+Period".action.expel-window-from-column = {};

        # Move windows within a workspace
        "Mod+Ctrl+Down".action.move-window-down = {};
        "Mod+Ctrl+Up".action.move-window-up = {};
        "Mod+Ctrl+J".action.move-window-down = {};
        "Mod+Ctrl+K".action.move-window-up = {};

        # Move columns within a workspace
        "Mod+Ctrl+Left".action.move-column-left = {};
        "Mod+Ctrl+Right".action.move-column-right = {};
        "Mod+Ctrl+H".action.move-column-left = {};
        "Mod+Ctrl+L".action.move-column-right = {};
        "Mod+Ctrl+Home".action.move-column-to-first = {};
        "Mod+Ctrl+End".action.move-column-to-last = {};

        # Move windows between monitors
        "Mod+Shift+Ctrl+Left".action.move-column-to-monitor-left = {};
        "Mod+Shift+Ctrl+Down".action.move-column-to-monitor-down = {};
        "Mod+Shift+Ctrl+Up".action.move-column-to-monitor-up = {};
        "Mod+Shift+Ctrl+Right".action.move-column-to-monitor-right = {};
        "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = {};
        "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = {};
        "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = {};
        "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = {};

        # Move windows between workspaces
        "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = {};
        "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up = {};
        "Mod+Ctrl+U".action.move-column-to-workspace-down = {};
        "Mod+Ctrl+I".action.move-column-to-workspace-up = {};

        # Move entire workspaces between monitors
        "Mod+Alt+Ctrl+Left".action.move-workspace-to-monitor-left = {};
        "Mod+Alt+Ctrl+Down".action.move-workspace-to-monitor-down = {};
        "Mod+Alt+Ctrl+Up".action.move-workspace-to-monitor-up = {};
        "Mod+Alt+Ctrl+Right".action.move-workspace-to-monitor-right = {};
        "Mod+Alt+Ctrl+H".action.move-workspace-to-monitor-left = {};
        "Mod+Alt+Ctrl+J".action.move-workspace-to-monitor-down = {};
        "Mod+Alt+Ctrl+K".action.move-workspace-to-monitor-up = {};
        "Mod+Alt+Ctrl+L".action.move-workspace-to-monitor-right = {};

        # Move workspaces up/down (within a monitor)
        "Mod+Shift+Page_Down".action.move-workspace-down = {};
        "Mod+Shift+Page_Up".action.move-workspace-up = {};
        "Mod+Shift+U".action.move-workspace-down = {};
        "Mod+Shift+I".action.move-workspace-up = {};

        # Resize windows
        "Mod+M".action.maximize-window-to-edges = {};
        "Mod+Shift+F".action.fullscreen-window = {};
        "Mod+Shift+Minus".action.set-window-height = "-10%";
        "Mod+Shift+Equal".action.set-window-height = "+10%";

        # Resize columns
        "Mod+R".action.switch-preset-column-width = {};
        "Mod+Shift+R".action.switch-preset-window-height = {};
        "Mod+Ctrl+R".action.reset-window-height = {};
        "Mod+F".action.maximize-column = {};
        "Mod+Ctrl+F".action.expand-column-to-available-width = {};
        "Mod+Minus".action.set-column-width = "-10%";
        "Mod+Equal".action.set-column-width = "+10%";

        # Visually move columns
        "Mod+C".action.center-column = {};
        "Mod+Ctrl+C".action.center-visible-columns = {};

        # Float windows
        "Mod+V".action.toggle-window-floating = {};
        "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = {};

        # Toggle tabbed vs stacked cilumn
        "Mod+W".action.toggle-column-tabbed-display = {};
      };
    };
  };
}
