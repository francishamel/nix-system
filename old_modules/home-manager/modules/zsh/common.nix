{ config, ... }:

{
  programs.zsh = {
    dotDir = "${config.xdg.configHome}/zsh";
    enable = true;
    historySubstringSearch.enable = true;
    initContent = ''
      # This is needed for autocompletion to work with aliases
      setopt completealiases

      bindkey '^U' backward-kill-line
    '';
  };
}
