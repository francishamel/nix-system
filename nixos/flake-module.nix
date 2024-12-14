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
