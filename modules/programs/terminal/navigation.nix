{
  delib,
  lib,
  ...
}: let
in
  delib.module {
    name = "programs.terminal";

    home.ifEnabled = {myconfig, ...}: {
      programs.fish = lib.mkIf myconfig.programs.terminal.fish.enable {
        # Always ls/eza after cd-ing.
        #
        # Note: this uses the eza alias defined in ./filesystem.nix
        #
        # Note: we use shellInit here with the weird 'functions -c' because
        # cd is _already_ a wrapper function, and we want to wrap the wrapper.
        # See: https://github.com/BryceBeagle/nixos-config/issues/356
        shellInit = ''
          functions -c cd standard_cd
          function cd --wraps cd
              standard_cd $argv
              and eza
          end
        '';
      };
    };
  }
