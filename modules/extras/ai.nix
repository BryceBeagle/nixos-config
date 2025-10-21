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
    programs.unfree.allowUnfree = ["claude-code"];
  };

  darwin.ifEnabled = {
    # Ideally this would be installed via `home-manager` but there are issues with
    # nix-darwin and GUI programs.
    # https://github.com/BryceBeagle/nixos-config/issues/245
    homebrew.casks = ["cursor"];

    environment.systemPackages = with pkgs; [
      claude-code
    ];
  };

  home.ifEnabled = {myconfig, ...}:
    lib.mkIf myconfig.programs.neovim.enable {
      programs.nixvim.plugins.claude-code.enable = true;
    };
}
