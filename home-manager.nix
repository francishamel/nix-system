{ config, pkgs, ... }: {
  home.packages = with pkgs; [ nixfmt ];

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

    ssh = {
      enable = true;
      extraConfig = ''
        IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
      '';
    };

    starship.enable = true;

    tmux.enable = true;

    vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        alefragnani.project-manager
        bbenoist.nix
        brettm12345.nixfmt-vscode
        eamodio.gitlens
        pkief.material-icon-theme
        redhat.vscode-yaml
      ];
      userSettings = {
        "diffEditor.ignoreTrimWhitespace" = false;
        "editor.fontFamily" = "'FiraCode Nerd Font'";
        "editor.fontLigatures" = true;
        "editor.minimap.enabled" = false;
        "editor.tabSize" = 2;
        "elixirLS.dialyzerEnabled" = false;
        "elixirLS.suggestSpecs" = false;
        "extensions.autoUpdate" = false;
        "files.insertFinalNewline" = true;
        "git.confirmSync" = false;
        "projectManager.git.baseFolders" = [ "~/.nixpkgs" "~/src" ];
        "telemetry.telemetryLevel" = "off";
        "workbench.colorTheme" = "Solarized Dark";
        "workbench.iconTheme" = "material-icon-theme";
      };
    };

    zsh = {
      dotDir = ".config/zsh";
      enable = true;
      initExtra = ''
        bindkey '^[[1;3C' emacs-forward-word
        bindkey '^[[1;3D' emacs-backward-word
        eval "$(op completion zsh)"; compdef _op op
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
