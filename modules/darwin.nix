{
  flake.modules.darwin = {
    base = {
      # TODO: time concern
      time.timeZone = "America/Montreal";

      # TODO: security concern
      security.pam.services.sudo_local.touchIdAuth = true;

      # TODO: Desktop manager concern
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

      # TODO: homebrew concern
      homebrew = {
        onActivation = {
          autoUpdate = false;
          cleanup = "zap";
          upgrade = false;
        };
        enable = true;
        casks = [
          "arc"
          "claude"
          "linear-linear"
          "mongodb-compass"
          "obsidian"
          "postman"
          "raycast"
          "slack"
          "spotify"
        ];
      };

      # TODO: Networking concern
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
