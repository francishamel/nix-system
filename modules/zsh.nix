{
  flake.modules.homeManager = {
    base =
      { config, ... }:
      {
        programs.zsh = {
          enable = true;
          dotDir = "${config.xdg.configHome}/zsh";
          historySubstringSearch.enable = true;
          syntaxHighlighting.enable = true;
          initContent = ''
            # Load edit-command-line widget
            autoload -Uz edit-command-line
            zle -N edit-command-line
            bindkey '^x^e' edit-command-line

            # Bind magic-space
            bindkey ' ' magic-space

            # Enable zmv (used to rename multiple files easily)
            autoload zmv
          '';
        };
      };
    darwin = {
      # Disable last login message
      home.file.".hushlogin".text = "";

      programs.zsh.initContent = ''
        # Global aliases
        alias -g C='| pbcopy'
        alias -g OR='op run -- '

        # Nix cleanup function
        nix-clean() {
          echo "Deleting old system generations (keeping last 3)..."
          sudo -H nix-env --delete-generations +3 --profile /nix/var/nix/profiles/system

          echo "Deleting old home-manager generations (keeping last 3)..."
          nix-env --delete-generations +3 --profile ~/.local/state/nix/profiles/home-manager

          echo "Running garbage collection..."
          sudo -H nix-collect-garbage -d

          echo "Done! Check space with: df -h"
        }
      '';
    };
    darwinAarch64 = {
      # Brew installation changed on Darwin ARM
      programs.zsh.initContent = ''
        eval "$(/opt/homebrew/bin/brew shellenv)"
      '';
    };
  };
}
