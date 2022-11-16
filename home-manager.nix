{ config, pkgs, ... }:

{
  imports = [
    ./1password.nix
    ./vscode.nix
  ];

  home = {
    packages = with pkgs; [ nixpkgs-fmt ];
    stateVersion = "22.11";
  };

  nix.registry.francishamel = {
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
      config = {
        theme = "Solarized (dark)";
      };
      enable = true;
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    gh.enable = true;

    git = {
      aliases = { fp = "fetch --prune"; };
      enable = true;
      extraConfig = {
        core.editor = "code --wait";
        init.defaultBranch = "main";
        merge.conflictstyle = "diff3";
        pull.rebase = true;
        rebase = {
          autoStash = true;
          autosquash = true;
        };
      };
      userEmail = "francishamel96@gmail.com";
      userName = "Francis Hamel";
    };

    home-manager.enable = true;

    lsd = {
      enable = true;
      enableAliases = true;
    };

    ssh.enable = true;

    starship.enable = true;

    tmux.enable = true;

    zsh = {
      dotDir = ".config/zsh";
      enable = true;
      initExtra = ''
        bindkey -e  # set emacs bindkeys
      '';
      oh-my-zsh = {
        enable = true;
        plugins = [ "sudo" ];
      };
      shellAliases = {
        "cat" = "${pkgs.bat}/bin/bat";
        ".." = "cd ..";
      };
    };
  };
}
