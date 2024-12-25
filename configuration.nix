# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz";
  impermanence = builtins.fetchTarball "https://github.com/nix-community/impermanence/archive/master.tar.gz";
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
     (import "${home-manager}/nixos")
      "${impermanence}/nixos.nix"
    ]; 

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # persist some system directories
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/alsa"
      "/var/lib/bluetooth"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
    ];
  };

  # Without this, impermanance makes sudo give lecture every reboot
  security.sudo.extraConfig = "Defaults lecture = never";

  networking.hostName = "poundcake"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
    # useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.excludePackages = [ pkgs.xterm ];
  services.gnome.core-utilities.enable = false;
  environment.gnome.excludePackages = with pkgs; [
    gnome.gnome-shell-extensions
    gnome-tour
  ];
  
  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable sound.
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    curl
    just
    neovim
    tree
    wget

    # Gnome tools
    loupe
    gedit
    gnome.baobab
    gnome.gnome-calculator
    gnome.gnome-screenshot
    gnome.gnome-system-monitor
    gnome.gnome-terminal
    gnome.gnome-tweaks
    gnome.nautilus

    libinput

    discord
    spotify
    timeshift
  ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "discord"
      "spotify"
    ];

  programs.fuse.userAllowOther = true;  # required for 'home-manager...home.persistence.allowOther = true'
  programs.git.enable = true;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  environment = {
    shells = with pkgs; [zsh];
    variables.EDITOR = "nvim";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ignormies = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialPassword = "foobar";
  };
  home-manager.users.ignormies = {
    imports = [
      "${impermanence}/home-manager.nix"
    ];
    home.stateVersion = "24.05";
    
    programs.home-manager.enable = true;

    # https://support.mozilla.org/en-US/kb/profiles-where-firefox-stores-user-data#w_what-information-is-stored-in-my-profile
    home.persistence."/persist/home/ignormies" = {
      directories = [
        ".ssh"
        ".mozilla/firefox/default/extensions"
	"git"
      ];
      files = [
        ".mozilla/firefox/default/cookies.sqlite"
        ".mozilla/firefox/default/favicons.sqlite"
        # Permissions and zoom levels for each site
        ".mozilla/firefox/default/permissions.sqlite"
        ".mozilla/firefox/default/content-prefs.sqlite"
        # Browser history and bookmarks
        ".mozilla/firefox/default/places.sqlite"
        # I guess this is useful? 
        # https://bugzilla.mozilla.org/show_bug.cgi?id=1511384
        # https://developer.mozilla.org/en-US/docs/Web/API/Storage_API/Storage_quotas_and_eviction_criteria
        ".mozilla/firefox/default/storage.sqlite"
	# Extension configuration
        ".mozilla/firefox/default/extension-settings.json"
      ];
      allowOther = true;
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
    };

    programs.git = {
      enable = true;
      userEmail = "bryce.beagle@gmail.com";
      userName = "ignormies";
    };

    programs.firefox = {
      enable = true;
      package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
        extraPolicies = {
          EnableTrackingProtection = {
            Value= true;
            Locked = true;
            Cryptomining = true;
            Fingerprinting = true;
          };
          ExtensionSettings = {
	    # Would like to enable, but doing so prevents access to about:debugging
	    # https://bugzilla.mozilla.org/show_bug.cgi?id=1778559
	    # 
	    # "*" = {
	    #   blocked_install_message = "Modify the NixOS config dingus!";
	    #   installation_mode = "blocked";
	    # };

            # https://www.reddit.com/r/firefox/comments/1afja73/how_to_get_an_extensions_name_gpo/

            "addon@darkreader.org" = {
	      install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
              installation_mode = "force_installed";
	    };
	    "uBlock0@raymondhill.net" = {
	      install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
              installation_mode = "force_installed";
	    };
	    "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
	      install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
              installation_mode = "force_installed";
	    };
          };
        };
      };

      profiles.default = {
        # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.firefox.profiles._name_.containersForce
        containersForce = true;
	# https://nix-community.github.io/home-manager/options.xhtml#opt-programs.firefox.profiles._name_.search.force
	search.force = true;

	search.engines = {

	  # Hide the other useless search engines from the bottom
          "Amazon.com".metaData.hidden = true;
          "Bing".metaData.hidden = true;
          "DuckDuckGo".metaData.hidden = true;
          "eBay".metaData.hidden = true;
          "Wikipedia (en)".metaData.hidden = true;
	};
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
	  "browser.urlbar.suggest.topsites" = false;
	  "browser.urlbar.suggest.trending" = false;
	  "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
	  "browser.urlbar.suggest.quicksuggest.sponsored" = false;
	  "browser.urlbar.suggest.yelp" = false;

	  # Addons junk
	  "extensions.htmlaboutaddons.recommendations.enabled" = false;

	  # Prevent firefox from warning before going to about:config
	  "browser.aboutConfig.showWarning" = false;

	  # Don't try to store passwords. Using BitWarden for this
	  "signon.rememberSignons" = false;

	  # Don't worry about missing session files (deleted via impermanence)
	  "browser.sessionstore.max_resumed_crashes" = -1;
	};
      };
    };
  };

  system.stateVersion = "24.05";
}
