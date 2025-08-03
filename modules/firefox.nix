{
  delib,
  inputs,
  pkgs,
  ...
}:
delib.module {
  name = "firefox";

  options = delib.singleEnableOption false;

  home.ifEnabled.home.persistence."/persist/home/ignormies" = {
    directories = [
      ".mozilla/firefox/default/extensions/"
      # Extension data is stored here, but also IndexedDB data for random websites
      # See https://github.com/BryceBeagle/nixos-config/issues/151
      ".mozilla/firefox/default/storage/default/"
    ];
    files = [
      ".mozilla/firefox/default/cookies.sqlite"
      ".mozilla/firefox/default/favicons.sqlite"
      # Permissions and zoom levels for each site
      ".mozilla/firefox/default/permissions.sqlite"
      ".mozilla/firefox/default/content-prefs.sqlite"
      # Browser history and bookmarks
      ".mozilla/firefox/default/places.sqlite"
      # Contains extension GUIDs that need to match entries in
      # .mozilla/firefox/default/storage/default (persisted above)
      ".mozilla/firefox/default/prefs.js"
      # I guess this is useful?
      # https://bugzilla.mozilla.org/show_bug.cgi?id=1511384
      # https://developer.mozilla.org/en-US/docs/Web/API/Storage_API/Storage_quotas_and_eviction_criteria
      ".mozilla/firefox/default/storage.sqlite"
      # Extension configuration
      ".mozilla/firefox/default/extension-settings.json"
    ];
  };

  home.ifEnabled.programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      extraPolicies = {
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
      };
    };

    profiles.default = {
      # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.firefox.profiles._name_.containersForce
      containersForce = true;
      # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.firefox.profiles._name_.search.force
      search.force = true;

      search.engines = {
        "GitHub" = {
          urls = [{template = "https://github.com/search?type=code&q={searchTerms}";}];
          definedAliases = ["cs"];
        };
        "Google Maps" = {
          urls = [{template = "https://google.com/maps/search/{searchTerms}";}];
          definedAliases = ["m"];
        };
      };

      extensions.packages = with inputs.firefox-addons.packages.${pkgs.system}; [
        bitwarden
        darkreader
        ublock-origin
      ];

      settings = {
        # First launch
        "app.normandy.first_run" = false;
        "browser.aboutwelcome.enabled" = false;
        "browser.rights.3.shown" = true;
        "datareporting.policy.dataSubmissionPolicyBypassNotification" = true;

        # New tab page junk
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.weatherfeed" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.showWeather" = false;
        "browser.newtabpage.activity-stream.system.showSponsored" = false;
        "browser.newtabpage.activity-stream.system.showWeather" = false;
        "browser.newtabpage.activity-stream.weather.locationSearchEnabled" = false;

        # Search junk
        "browser.urlbar.scotchBonnet.enableOverride" = true;
        "browser.urlbar.suggest.topsites" = false;
        "browser.urlbar.suggest.trending" = false;
        "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.urlbar.suggest.yelp" = false;

        # Addons junk
        "extensions.htmlaboutaddons.recommendations.enabled" = false;

        # Pocket junk
        "browser.urlbar.suggest.pocket" = false;
        "extensions.pocket.enabled" = false;

        # Prevent Firefox from warning before going to about:config
        "browser.aboutConfig.showWarning" = false;

        # Don't try to store passwords. Using Bitwarden for this
        "signon.rememberSignons" = false;

        # Don't worry about missing session files (deleted via impermanence)
        "browser.sessionstore.max_resumed_crashes" = -1;

        # Prevent Firefox from suggesting to re-open tabs from last session
        "browser.startup.couldRestoreSession.count" = -1;

        # Default Ctrl-F to highlight all results by default
        "findbar.highlightAll" = true;

        # Allow extensions to be auto-enabled
        "extensions.autoDisableScopes" = 0;
      };
    };
  };
}
