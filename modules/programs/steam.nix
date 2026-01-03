{delib, ...}:
delib.module {
  name = "programs.steam";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled = {
    impermanence.user = {
      directories = [
        "games/steam/"
      ];
    };

    programs.unfree.allowUnfree = [
      "steam"
      "steam-unwrapped"
    ];
  };

  nixos.ifEnabled.programs.steam = {
    enable = true;
  };
}
