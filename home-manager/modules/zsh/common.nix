{ ... }:

{
  programs.zsh = {
    dotDir = ".config/zsh";
    enable = true;
    historySubstringSearch.enable = true;
    shellAliases.".." = "cd ..";
    initExtra = ''
      bindkey '^U' backward-kill-line
    '';
  };
}
