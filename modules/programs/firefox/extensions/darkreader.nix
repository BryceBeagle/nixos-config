{
  delib,
  inputs,
  pkgs,
  ...
}:
delib.module {
  name = "programs.firefox";

  home.ifEnabled.programs.firefox = {
    profiles.default.extensions = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; {
      packages = [
        darkreader
      ];

      settings."${darkreader.addonId}".settings = {
        # Without this, DarkReader stores configuration in storage-sync.sqlite,
        # intended to be backed up and shared across multiple devices
        syncSettings = false;

        # Use an opt-in list rather than opt-out
        enabledByDefault = false;
        enabledFor = [
          "news.ycombinator.com"
        ];

        schemeVersion = 2;
      };
    };
  };
}
