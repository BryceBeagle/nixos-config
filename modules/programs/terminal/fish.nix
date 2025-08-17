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

    # Disable "Welcome to fish" message
    functions.fish_greeting = "";
  };
}
