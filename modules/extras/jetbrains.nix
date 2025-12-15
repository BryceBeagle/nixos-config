{
  delib,
  pkgs,
  ...
}:
delib.module {
  name = "extras.jetbrains";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled = {
    programs.unfree.allowUnfree = ["idea-ultimate"];
  };

  home.ifEnabled.home.packages = with pkgs; [
    jetbrains.idea-ultimate
  ];
}
