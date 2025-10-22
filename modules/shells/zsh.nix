{
  flake.modules.homeManager.base =
    { config, ... }:
    {
      programs.zsh = {
        enable = true;
        dotDir = "${config.xdg.configHome}/zsh";
        historySubstringSearch.enable = true;
        # TODO: ensure we don't eval brew on x86_64 darwin
        initContent = ''
          bindkey '^U' backward-kill-line

          eval "$(/opt/homebrew/bin/brew shellenv)"
        '';
      };

      # TODO: ensure we do that only for all darwin
      # Disable last login message
      home.file.".hushlogin".text = "";
    };
}

