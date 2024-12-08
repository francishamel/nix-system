{ ... }:

{
  programs.zsh = {
    dotDir = ".config/zsh";
    enable = true;
    historySubstringSearch.enable = true;
    initExtra = ''
      bindkey '^U' backward-kill-line
    '';
  };
}
