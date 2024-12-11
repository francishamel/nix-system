{ ... }:

{
  flake.nixosModules = {
    common = {
      nix = {
        extraOptions = "experimental-features = nix-command flakes";

        gc = {
          automatic = true;
          interval = {
            Weekday = 0;
          };
          options = "--delete-older-than 30d";
        };
      };

      nixpkgs.config.allowUnfree = true;

      time.timeZone = "America/Montreal";
    };
    darwin = {
      imports = [
        ./darwin/dock.nix
        ./darwin/finder.nix
        ./darwin/homebrew.nix
        ./darwin/mouse.nix
        ./darwin/networking.nix
      ];

      # Needed for correct $PATH
      programs.zsh.enable = true;

      security.pam.enableSudoTouchIdAuth = true;

      services.nix-daemon.enable = true;

      system.defaults = {
        ".GlobalPreferences"."com.apple.sound.beep.sound" = "/System/Library/Sounds/Blow.aiff";
        loginwindow.GuestEnabled = false;
      };

      # Needed for home-manager to work
      # TODO: parameterize the user name
      users.users.francis = {
        name = "francis";
        home = "/Users/francis";
      };

      system.stateVersion = 4;
    };
  };
}
