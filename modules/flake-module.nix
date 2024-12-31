{ ... }:

{
  flake.nixosModules = {
    common = {
      nix = {
        extraOptions = "experimental-features = nix-command flakes";

        gc = {
          automatic = true;
          options = "--delete-older-than 30d";
        };

        settings = {
          substituters = [
            "https://devenv.cachix.org"
          ];
          trusted-public-keys = [
            "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
          ];
        };
      };

      nixpkgs.config.allowUnfree = true;

      time.timeZone = "America/Montreal";
    };
    darwin = {
      # Needed for correct $PATH
      programs.zsh.enable = true;

      security.pam.enableSudoTouchIdAuth = true;

      services.nix-daemon.enable = true;

      system.defaults = {
        ".GlobalPreferences"."com.apple.sound.beep.sound" = "/System/Library/Sounds/Blow.aiff";
        loginwindow.GuestEnabled = false;
        dock = {
          autohide = true;
          autohide-delay = 0.1;
          autohide-time-modifier = 0.5;
          enable-spring-load-actions-on-all-items = false;
          launchanim = false;
          mru-spaces = false;
          show-process-indicators = false;
          static-only = true;

          # Disable all hot corners
          wvous-tl-corner = 1;
          wvous-tr-corner = 1;
          wvous-bl-corner = 1;
          wvous-br-corner = 1;
        };
        finder = {
          AppleShowAllExtensions = true;
          FXEnableExtensionChangeWarning = false;
          QuitMenuItem = true;
        };
        NSGlobalDomain = {
          "com.apple.swipescrolldirection" = false;
          "com.apple.trackpad.scaling" = 1.25;
        };
      };

      # Needed for home-manager to work
      # TODO: parameterize the user name
      users.users.francis = {
        name = "francis";
        home = "/Users/francis";
      };

      homebrew = {
        onActivation = {
          autoUpdate = false;
          cleanup = "zap";
          upgrade = false;
        };
        enable = true;
        casks = [
          "1password"
          "1password-cli"
          "arc"
          "datagrip"
          "google-chrome"
          "obsidian"
          "raycast"
          "spotify"
          "todoist"
          "yubico-yubikey-manager"
        ];
      };

      networking = {
        dns = [
          "1.1.1.1" # Cloudflare's primary dns
          "1.0.0.1" # Cloudflare's secondary dns
          "8.8.8.8" # Google's primary dns
          "8.8.4.4" # Google's secondary dns
        ];

        knownNetworkServices = [ "Wi-Fi" ];
      };

      system.stateVersion = 5;
    };
  };
}
