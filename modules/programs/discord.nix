{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "programs.discord";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled = {
    impermanence.user.directories = [
      ".config/discord"
    ];

    programs.unfree.allowUnfree = ["discord"];
  };

  home.ifEnabled.home.packages = with pkgs; [
    discord
  ];
}
