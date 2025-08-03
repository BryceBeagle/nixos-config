{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "discord";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled.persist.user.directories = [
    ".config/discord"
  ];

  home.ifEnabled.home.packages = with pkgs; [
    discord
  ];
}
