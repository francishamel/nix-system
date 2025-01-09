{ ... }:

{
  programs.zsh = {
    dotDir = ".config/zsh";
    enable = true;
    historySubstringSearch.enable = true;
    initExtra = ''
      # This is needed for autocompletion to work with aliases
      setopt completealiases

      bindkey '^U' backward-kill-line
    '';
  };
}
