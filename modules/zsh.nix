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
