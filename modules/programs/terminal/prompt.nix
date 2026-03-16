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
        set -l git_branch_icon   # Nerd Fonts nf-dev-git_branch e725

        set -l last_status $status

        set -l color_normal (set_color normal)
        set -l color_branch (set_color $fish_color_end)
        set -l color_cwd (set_color $fish_color_cwd)
        set -l color_user (set_color $fish_color_user)

        set -l user $color_user $USER $color_normal
        set -l cwd $color_cwd (prompt_pwd) $color_normal

        set -l maybe_branch
        if set branch_name (git branch --show-current 2>/dev/null)
            set -l branch $git_branch_icon " " $branch_name
            set maybe_branch " " $color_branch $branch $color_normal
        else
            set maybe_branch ""
        end

        set -l color_dot
        if test $last_status -eq 0
            set color_dot (set_color $fish_color_end)
        else
            set color_dot (set_color $fish_color_status)
        end
        set -l dot $color_dot "▪" $color_normal

        string join "" -- '╭─(' $user ')(' $cwd ')' $maybe_branch
        string join "" -- '╰──' $dot ' '
      '';
    };
  };
}
