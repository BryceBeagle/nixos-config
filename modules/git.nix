{delib, ...}:
delib.module {
  name = "git";

  options = delib.singleEnableOption true;

  myconfig.ifEnabled.persist.user = {
    directories = [
      "git"
    ];
    files = [
      # gh CLI stores credentials here
      ".config/gh/hosts.yml"
    ];
  };

  home.ifEnabled.programs.git = {
    enable = true;
    userEmail = "bryce.beagle@gmail.com";
    userName = "ignormies";
  };

  home.ifEnabled.programs.gh = {
    enable = true;

    settings.git_protocol = "ssh";
  };
}
