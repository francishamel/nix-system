{ config, pkgs, ... }:

{
  imports = [
    ./1password.nix
    ./alacritty.nix
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
