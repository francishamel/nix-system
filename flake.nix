{
  inputs = {
    # Principle inputs (updated by `nix run .#update`)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin.url = "github:lnl7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-flake.url = "github:srid/nixos-flake";
  };

  outputs = inputs@{ self, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-darwin" ];
      imports = [ inputs.nixos-flake.flakeModule ];

      flake = {
        # Configurations for macOS machines
        darwinConfigurations."MacBook-Pro-Intel" = self.nixos-flake.lib.mkIntelMacosSystem {
          imports = [
            # Your nix-darwin configuration goes here
            ({ pkgs, ... }: {
              users.users.francis = {
                uid = 501;
                createHome = true;
                home = "/Users/francis";
                shell = pkgs.zsh;
                isHidden = false;
              };

              users.knownUsers = [ "francis" ];

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

                # TODO: replace by myself
                settings.trusted-users = [ "francis" ];
              };
            })
            # Setup home-manager in nix-darwin config
            self.darwinModules.home-manager
            ({ pkgs, ... }: {
              home-manager.users.francis = {
                imports = [ self.homeModules.default ];
                home = {
                  stateVersion = "22.11";
                  packages = with pkgs;[
                    cachix
                    dive
                    d2
                    flyctl
                    yubikey-manager
                  ];
                };
                programs = {
                  home-manager.enable = true;
                  starship.enable = true;
                };
              };
            })
          ];
        };

        # home-manager configuration goes here.
        homeModules.default = { pkgs, ... }: {
          imports = import ./home/list.nix;
        };
      };
    };
}
