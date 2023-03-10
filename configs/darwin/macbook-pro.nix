{ pkgs, ... }:

{
  imports = [
    ../../profiles/darwin/users/francis
  ];

  # TODO: refactor this to profiles for common stuff

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      (
        nerdfonts.override {
          fonts = [
            "FiraCode"
          ];
        }
      )
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

    hostName = "MacBook-Pro-Intel";
  };

  # Make zsh the default shell
  programs.zsh.enable = true;

  time.timeZone = "America/Montreal";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Enable sudo with Touch ID
  security.pam.enableSudoTouchIdAuth = true;

  homebrew = {
    onActivation = {
      autoUpdate = false;
      cleanup = "zap";
    };
    enable = true;
    casks = [
      "1password"
      "1password-cli"
      "calibre"
      "discord"
      "docker"
      "firefox"
      "obsidian"
      "raycast"
      "slack"
      "spotify"
      "todoist"
      "zotero"

      # Temporary needed software
      # "microsoft-teams"
      # "zoom"
    ];
  };

  # Mouse settings
  system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = false;
  system.defaults.NSGlobalDomain."com.apple.trackpad.scaling" = 1.25;

  system.defaults.dock = {
    autohide = true;
    autohide-delay = 0.1;
    autohide-time-modifier = 0.5;
    enable-spring-load-actions-on-all-items = false;
    launchanim = false;
    mru-spaces = false;
    show-process-indicators = false;
    static-only = true;
  };

  system.defaults.finder = {
    AppleShowAllExtensions = true;
    FXEnableExtensionChangeWarning = false;
    QuitMenuItem = true;
  };

  # Sound settings
  system.defaults.".GlobalPreferences"."com.apple.sound.beep.sound" = "/System/Library/Sounds/Blow.aiff";

  system.defaults.loginwindow.GuestEnabled = false;

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    gc = {
      automatic = true;
      interval = {
        Weekday = 0;
      };
      options = "--delete-older-than 30d";
    };

    registry.francishamel = {
      from = {
        id = "francishamel";
        type = "indirect";
      };
      to = {
        owner = "francishamel";
        repo = "nix-templates";
        type = "github";
        ref = "main";
      };
    };
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
