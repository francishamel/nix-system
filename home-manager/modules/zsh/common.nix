{ ... }:

{
  programs.zsh = {
    defaultKeymap = "emacs";
    dotDir = ".config/zsh";
    enable = true;
    historySubstringSearch.enable = true;
    shellAliases.".." = "cd ..";
  };
}
