# Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }: {

  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.impermanence.nixosModules.impermanence
  ];

  nix.settings.experimental-features = [ "flakes" ];

  # Use systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Persist some system directories
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

  networking.hostName = "poundcake";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Los_Angeles";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    excludePackages = [ pkgs.xterm ];

    xkb.options = "ctrl:nocaps";
  };

  services.gnome.core-utilities.enable = false;
  environment.gnome.excludePackages = with pkgs; [
    gnome-shell-extensions
    gnome-tour
  ];
  
  # Enable sound.
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # CLI tools
    curl
    jq
    just
    libinput
    neovim
    ripgrep
    tree
    unzip
    usbutils
    wget

    # Gnome tools
    loupe
    gedit
    baobab
    gnome-calculator
    gnome-screenshot
    gnome-system-monitor
    gnome-terminal
    gnome-tweaks
    nautilus
    gnomeExtensions.paperwm

    # Programming
    cargo
    gcc
    rust-analyzer
    rustc

    # Human programs
    discord
    spotify
    timeshift
  ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "discord"
      "spotify"
    ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];

  programs.fuse.userAllowOther = true;  # required for 'home-manager...home.persistence.allowOther = true'
  programs.git.enable = true;

  programs.zsh.enable = true;
  programs.fish.enable = true;

  # Default shell for users (i.e. in a terminal emulator)
  users.defaultUserShell = pkgs.fish;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  users.mutableUsers = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ignormies = {
    isNormalUser = true;
    extraGroups = [
      # Configure network settings
      "networkmanager"
      # Use sudo
      "wheel" 
    ];
    initialPassword = "foobar";
  };
  home-manager.users.ignormies = { lib, ... }: {
    imports = [
      inputs.impermanence.homeManagerModules.impermanence
      inputs.nixvim.homeManagerModules.nixvim
    ];
    home.stateVersion = "24.05";
    
    programs.home-manager.enable = true;

    # https://support.mozilla.org/en-US/kb/profiles-where-firefox-stores-user-data#w_what-information-is-stored-in-my-profile
    home.persistence."/persist/home/ignormies" = {
      directories = [
        ".config/discord"
        # Contains fish_history. Needs to be dir because Fish overwrites symlinks
        ".local/share/fish"
        ".mozilla/firefox/default/extensions"
        ".ssh"
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

        # gh CLI stores credentials here
        ".config/gh/hosts.yml"
      ];
      allowOther = true;
    };

    dconf.settings = with lib.hm.gvariant; {
      "org/gnome/desktop/input-sources" = {
        sources = [ (mkTuple [ "xkb" "us" ]) ];
        xkb-options = [ "compose:ralt" ];
      };
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        enable-hot-corners = false;
      };
      "org/gnome/desktop/peripherals/keyboard" = {
        delay = 150;
        repeat-interval = 15;
      };
      "org/gnome/desktop/peripherals/touchpad" = {
        natural-scroll = false;
      };
      "org/gnome/shell" = {
        # Installed above in systemPackages. Ideally this becomes more isolated when we
        # split into multiple modules
        enabled-extensions = [ pkgs.gnomeExtensions.paperwm.extensionUuid ];
      };
    };

    programs.git = {
      enable = true;
      userEmail = "bryce.beagle@gmail.com";
      userName = "ignormies";
    };

    programs.gh = {
      enable = true;

      settings.git_protocol = "ssh";
    };

    programs.nixvim = {
      enable = true;
      defaultEditor = true;

      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      opts = {
        number = true;  # Show line numbers
        tabstop = 4;  # 4 space tabs
        expandtab = true;  # <Tab> turns into spaces
        shiftwidth = 4;  # Shift+< and Shift+> indent 4 spaces
      };

      keymaps = [
        {
          mode = "n";
          key = "<leader><C-e>";
          action = ":Neotree buffers reveal float<CR>";
        }
        {
          mode = "n";
          key = "<leader><C-o>";
          action = ":Neotree filesystem toggle float<CR>";
        }
      ];

      colorschemes.catppuccin = {
        enable = true;
        settings.flavour = "macchiato";
      };

      plugins = {
        cmp-nvim-lsp.enable = true;
        web-devicons.enable = true;  # Used by neo-tree
        treesitter.enable = true;

        cmp = {
          enable = true;

          autoEnableSources = true;

          settings = {
            sources = [
              { name = "nvim_lsp"; }
              { name = "path"; }
              { name = "buffer"; }
            ];
          };
        };
        lsp = {
          enable = true;

          inlayHints = true;

          keymaps = {
            silent = true;
            lspBuf = {
              K = "hover";
            };
          };

          servers = {
            nil_ls.enable = true;

            rust_analyzer = {
              enable = true;

              # Use system-install packages
              installRustc = false;
              installCargo = false;
            };
          };
        };
        neo-tree = {
          enable = true;

          closeIfLastWindow = true;
          popupBorderStyle = "rounded";
        };
        telescope = {
          enable = true;

          keymaps = {
            "<leader>ff" = "find_files";
            "<leader>fg" = "live_grep";
          };
        };
      };
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
            "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
              installation_mode = "force_installed";
            };
            "uBlock0@raymondhill.net" = {
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
          "GitHub" = {
            urls = [{template = "https://github.com/search?type=code&q={searchTerms}";}];
            definedAliases = ["cs"];
          };
          "Google Maps" = {
            urls = [{template = "https://google.com/maps/search/{searchTerms}";}];
            definedAliases = ["m"];
          };

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
