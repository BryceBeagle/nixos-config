{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.terminal.fish";

  options = delib.singleEnableOption true;

  myconfig.ifEnabled.impermanence.user.directories = [
    # fish_history. Needs to be dir because Fish overwrites symlinks
    ".local/share/fish"
  ];

  # Default terminal configuration for other users
  nixos.ifEnabled = {
    # Default shell for all users
    users.defaultUserShell = pkgs.fish;

    programs = {
      fish.enable = true;

      # Backup if fish isn't working for some reason
      zsh.enable = true;
    };
  };

  darwin.ifEnabled = {myconfig, ...}: {
    # This uses the system-installed fish as the default user shell, but the config
    # in home-manager will still apply
    programs.fish.enable = true;

    # `nix-darwin` does not have a `users.defaultUserShell` option, so we do this
    # instead
    users.users.${myconfig.user.username}.shell = pkgs.fish;
  };

  home.ifEnabled.programs.fish = {
    enable = true;

    functions = {
      # Disable "Welcome to fish" message
      fish_greeting = "";

      fish_prompt = ''
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

        string join "" -- '┌─[' $user '][' $cwd ']'
        string join "" -- '└──' $dot ' '
      '';
    };
  };
}
