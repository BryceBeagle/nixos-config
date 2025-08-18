{delib, ...}:
delib.module {
  name = "user";

  options.user = with delib; {
    # TODO: Unfortunately, there is also the global `homeManagerUser` option in the
    # `flake.nix` config. So setting this will NOT adjust the `home-manager` user
    # https://github.com/yunfachi/denix/issues/37
    username = noDefault (strOption null);
    initialPassword = noDefault (strOption null);
  };

  nixos.always = {cfg, ...}: {
    users = {
      # Prevent users created outside of nix config
      mutableUsers = false;

      users.${cfg.username} = {
        isNormalUser = true;
        initialPassword = cfg.initialPassword;
      };
    };
  };

  darwin.always = {cfg, ...}: {
    system.primaryUser = cfg.username;

    users.users."${cfg.username}" = {
      name = cfg.username;
      home = "/Users/${cfg.username}/";
    };
  };
}
