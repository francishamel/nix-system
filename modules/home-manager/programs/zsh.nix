{ ... }:

{
  # Disable last login message
  home.file.".hushlogin".text = "";

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
