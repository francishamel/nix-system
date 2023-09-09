{ ... }:

{
  imports = [
    ./modules/dock.nix
    ./modules/finder.nix
    ./modules/fonts.nix
    ./modules/homebrew.nix
    ./modules/mouse.nix
    ./modules/networking.nix
    ./modules/users.nix
  ];

  # TODO: move this somewhere central
  nixpkgs.config.allowUnfree = true;

  # Make zsh the default shell
  programs.zsh.enable = true;

  time.timeZone = "America/Montreal";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Enable sudo with Touch ID
  security.pam.enableSudoTouchIdAuth = true;

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

    # TODO: replace by myself
    settings.trusted-users = [ "francis" ];
  };
}
