{
  delib,
  lib,
  ...
}:
delib.module {
  name = "programs.terminal";

  home.ifEnabled = {myconfig, ...}: {
    programs.fish = lib.mkIf myconfig.programs.terminal.fish.enable {
      functions.fish_prompt = ''
        set -l last_status $status

        set -l color_normal (set_color normal)
        set -l color_cwd (set_color $fish_color_cwd)
        set -l color_user (set_color $fish_color_user)

        set -l color_dot
        if test $last_status -eq 0
            set color_dot (set_color $fish_color_end)
        else
            set color_dot (set_color $fish_color_error)
        end
        set -l dot $color_dot "▪" $color_normal

        set -l user $color_user $USER $color_normal
        set -l cwd $color_cwd (prompt_pwd) $color_normal

        string join "" -- '╭─(' $user ')(' $cwd ')'
        string join "" -- '╰──' $dot ' '
      '';
    };
  };
}
