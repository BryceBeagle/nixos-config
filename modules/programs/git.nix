{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.git";

  options = delib.singleEnableOption true;

  myconfig.ifEnabled = {
    impermanence.user = {
      directories = [
        "git/"
      ];
      files = [
        # gh CLI stores credentials here
        ".config/gh/hosts.yml"
      ];
    };

    programs.unfree.allowUnfree = ["graphite-cli"];
  };

  nixos.ifEnabled.programs.git.enable = true;

  home.ifEnabled = {
    home.packages = with pkgs; [
      graphite-cli
    ];

    programs = {
      git = {
        enable = true;

        settings = {
          user.email = "bryce.beagle@gmail.com";
          user.name = "ignormies";
        };
      };

      gh = {
        enable = true;

        settings.git_protocol = "ssh";
      };
    };
  };
}
