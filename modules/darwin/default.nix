{ config, pkgs, ... }:

{
  imports = [
    ./homebrew.nix
    ./preferences.nix
  ];

  users = {
    knownUsers = [
      "francis"
    ];

    users.francis = {
      createHome = true;
      home = "/Users/francis";
      uid = 501;
    };
  };

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

  # Cleanup nix weekly on Sundays
  nix.gc = {
    automatic = true;
    interval = {
      Weekday = 0;
    };
    options = "--delete-older-than 30d";
  };

  # Enable nix flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  time.timeZone = "America/Montreal";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
