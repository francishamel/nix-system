{ config, pkgs, ... }:

{
  imports = [ <home-manager/nix-darwin> ];

  nixpkgs.config.allowUnfree = true;

  users = {
    knownUsers = [ "francis" ];
    
    users.francis = {
      createHome = true;
      home = "/Users/francis";
      uid = 1000;
    };
  };

  home-manager = {
    users.francis = { pkgs, ... }: {
      home.packages = with pkgs; [ nixfmt ];

      # Having this empty file in the home dir removes the last login message from the native terminal app.
      home.file.".hushlogin".text = "";

      programs = {
        alacritty = {
          enable = true;
          settings = {
            # Solarized dark color scheme
            colors = {
              primary = {
                background = "#002b36";
                foreground = "#839496";
              };
              cursor = {
                text = "#002b36";
                cursor = "#839496";
              };
              normal = {
                black = "#073642";
                red = "#dc322f";
                green = "#859900";
                yellow = "#b58900";
                blue = "#268bd2";
                magenta = "#d33682";
                cyan = "#2aa198";
                white = "#eee8d5";
              };
              bright = {
                black = "#586e75";
                red = "#cb4b16";
                green = "#586e75";
                yellow = "#657b83";
                blue = "#839496";
                magenta = "#6c71c4";
                cyan = "#93a1a1";
                white = "#fdf6e3";
              };
            };

            font = {
              normal = {
                family = "FiraCode Nerd Font";
                style = "Retina";
              };

              size = 14.0;
            };

            window = {
              dynamic_title = false;
              startup_mode = "Maximized";
              title = "Alacritty";
            };
          };
        };

        bat = {
          config = { theme = "Solarized (dark)"; };
          enable = true;
        };

        gh = {
          enable = true;
          enableGitCredentialHelper = true;
        };

        git = {
          aliases = { fp = "fetch --prune"; };
          enable = true;
          extraConfig = {
            core.editor = "code --wait";
            init.defaultBranch = "main";
            pull.rebase = true;
            rebase.autoStash = true;
          };
          userEmail = "francishamel96@gmail.com";
          userName = "Francis Hamel";
        };

        home-manager.enable = true;

        lsd = {
          enable = true;
          enableAliases = true;
        };

        starship.enable = true;

        vscode = {
          enable = true;
          extensions = with pkgs.vscode-extensions; [
            bbenoist.nix
            brettm12345.nixfmt-vscode
            eamodio.gitlens
            pkief.material-icon-theme
          ];
          userSettings = {
            "diffEditor.ignoreTrimWhitespace" = false;
            "editor.fontFamily" = "'FiraCode Nerd Font'";
            "editor.fontLigatures" = true;
            "editor.minimap.enabled" = false;
            "editor.tabSize" = 2;
            "extensions.autoUpdate" = false;
            "files.insertFinalNewline" = true;
            "git.confirmSync" = false;
            "telemetry.telemetryLevel" = "off";
            "workbench.colorTheme" = "Solarized Dark";
            "workbench.iconTheme" = "material-icon-theme";
          };
        };

        zsh = {
          dotDir = ".config/zsh";
          enable = true;
          oh-my-zsh = {
            enable = true;
            plugins = [ "sudo" ];
          };
          shellAliases = {
            "cat" = "bat";
            ".." = "cd ..";
          };
        };
      };
    };

    useGlobalPkgs = true;
    useUserPackages = true;
  };

  fonts = {
    enableFontDir = true;
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
      "discord"
      "firefox"
      "raycast"
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

  time.timeZone = "America/Montreal";

  system.defaults.loginwindow.GuestEnabled = false;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
