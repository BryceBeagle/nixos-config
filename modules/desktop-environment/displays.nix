{delib, ...}:
delib.module {
  name = "desktop-environment.displays";

  options = with delib;
    moduleOptions ({parent, ...}: {
      enable = boolOption parent.enable;

      # TODO: Make optional if/when we use NixOS w/o a built-in display
      builtinDisplay = noDefault (strOption null);
    });

  home.ifEnabled = {cfg, ...}: {
    services.kanshi = {
      enable = true;

      settings = let
        builtin = {
          criteria = cfg.builtinDisplay;
          scale = 1.0; # defaults to 1.5 for some reason
        };
        lg-mp57-0000 = {
          criteria = "LG Electronics LG IPS FULLHD 0x000810A1";
        };
        lg-mp57-0001 = {
          criteria = "LG Electronics LG IPS FULLHD 0x0008106D";
        };
        aoc-u3477 = {
          criteria = "PNP(AOC) U3477 0x000000FA";
        };
      in [
        {
          profile = {
            name = "home-desk";
            outputs = [
              (lg-mp57-0000 // {position = "0,360";})
              (aoc-u3477 // {position = "1920,0";})
              (lg-mp57-0001 // {position = "5360,360";})
              (builtin // {status = "disable";})
            ];
          };
        }
        {
          # Just the builtin display
          profile = {
            name = "nomad";
            outputs = [builtin];
          };
        }
      ];
    };
  };
}
