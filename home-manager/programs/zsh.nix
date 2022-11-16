{ ... }:

{
  programs.zsh = {
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
      ".." = "cd ..";
    };
  };
}
