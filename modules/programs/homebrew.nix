{delib, ...}:
delib.module {
  name = "programs.homebrew";

  options = delib.singleEnableOption false;

  darwin.ifEnabled = {myconfig, ...}: {
    homebrew = {
      enable = true;

      user = myconfig.user.username;
    };
  };
}
