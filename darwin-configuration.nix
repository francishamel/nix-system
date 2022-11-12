{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  users = {
    knownUsers = [ "francis" ];

    users.francis = {
      createHome = true;
      home = "/Users/francis";
      uid = 501;
    };
  };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [ (nerdfonts.override { fonts = [ "FiraCode" ]; }) ];
  };

  homebrew = {
    autoUpdate = false;
    cleanup = "zap";
    enable = true;
    global = {
      brewfile = true;
      noLock = true;
    };
    casks = [
      "1password"
      "1password-cli"
      "discord"
      "firefox"
      "obsidian"
      "raycast"
      "slack"
      "spotify"
      "todoist"
    ];
  };

  # Mouse settings
  system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = false;
  system.defaults.NSGlobalDomain."com.apple.trackpad.scaling" = "1.25";

  system.defaults.dock = {
    autohide = true;
    autohide-delay = "0.1";
    autohide-time-modifier = "0.5";
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
  system.defaults.".GlobalPreferences"."com.apple.sound.beep.sound" =
    "/System/Library/Sounds/Blow.aiff";

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

  # Cleanup nix weekly on Sundays
  nix.gc = {
    automatic = true;
    interval = { Weekday = 0; };
    options = "--delete-older-than 30d";
  };

  # Enable nix flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  time.timeZone = "America/Montreal";

  system.defaults.loginwindow.GuestEnabled = false;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
