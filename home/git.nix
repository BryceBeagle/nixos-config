{...}: {
  home.persistence."/persist/home/ignormies" = {
    directories = [
      "git"
    ];
    files = [
      # gh CLI stores credentials here
      ".config/gh/hosts.yml"
    ];
  };

  programs.git = {
    enable = true;
    userEmail = "bryce.beagle@gmail.com";
    userName = "ignormies";
  };

  programs.gh = {
    enable = true;

    settings.git_protocol = "ssh";
  };
}
