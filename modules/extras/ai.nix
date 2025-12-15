{
  delib,
  lib,
  pkgs,
  ...
}:
delib.module {
  name = "extras.ai";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled = {
    programs.unfree.allowUnfree = [
      "claude-code"
      "cursor"
    ];
  };

  darwin.ifEnabled = {
    environment.systemPackages = with pkgs; [
      claude-code
    ];
  };

  home.ifEnabled = {myconfig, ...}: {
    programs.nixvim.plugins.claude-code.enable = lib.mkIf myconfig.programs.neovim.enable false;

    home.packages = with pkgs; [code-cursor];
  };
}
