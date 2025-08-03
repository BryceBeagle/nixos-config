{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "discord";

  options = delib.singleEnableOption false;

  home.ifEnabled = {
    home.packages = with pkgs; [
      discord
    ];

    home.persistence."/persist/home/ignormies" = {
      directories = [
        ".config/discord"
      ];
    };
  };
}
