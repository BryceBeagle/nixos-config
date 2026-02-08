{
  delib,
  inputs,
  pkgs,
  ...
}:
delib.module {
  name = "programs.firefox";

  home.ifEnabled.programs.firefox = {
    profiles.default.extensions = {
      # Override all non-declared extension settings
      # Note that doing this forces _all_ extensions to have _all_ config codified
      force = true;

      packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
        bitwarden
        ublock-origin
      ];
    };
  };
}
