{ pkgs, ... }:

{
  users.users.francis = {
    uid = 501;
    createHome = true;
    home = "/Users/francis";
    shell = pkgs.zsh;
    isHidden = false;
  };

  users.knownUsers = [ "francis" ];

  home-manager.users.francis = import ./home.nix;
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  imports = [ ./nix.nix ];

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
      "discord"
      "docker"
      "firefox"
      "obsidian"
      "raycast"
      "slack"
      "spotify"

      # Temporary needed software
      # "balenaetcher" # For burning img/iso on sd cards/usb drive
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

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
