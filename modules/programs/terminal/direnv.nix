{delib, ...}:
delib.module {
  name = "programs.terminal.direnv";

  options = delib.singleEnableOption true;

  myconfig.ifEnabled.impermanence.user.directories = [
    # `direnv allow`-ed directories
    ".local/share/direnv/allow"
  ];

  home.ifEnabled.programs.direnv = {
    enable = true;

    silent = true;
  };
}
