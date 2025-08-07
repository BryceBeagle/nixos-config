{delib, ...}:
delib.module {
  name = "programs.git";

  options = delib.singleEnableOption true;

  myconfig.ifEnabled.impermanence.user = {
    directories = [
      "git/"
    ];
    files = [
      # gh CLI stores credentials here
      ".config/gh/hosts.yml"
    ];
  };

  nixos.ifEnabled.programs.git.enable = true;

  home.ifEnabled.programs = {
    git = {
      enable = true;

      userEmail = "bryce.beagle@gmail.com";
      userName = "ignormies";
    };

    gh = {
      enable = true;

      settings.git_protocol = "ssh";
    };
  };
}
