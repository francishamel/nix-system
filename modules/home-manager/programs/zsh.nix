{ ... }:

{
  # Disable last login message
  home.file.".hushlogin".text = "";

  programs.zsh = {
    defaultKeymap = "emacs";
    dotDir = ".config/zsh";
    enable = true;
    shellAliases.".." = "cd ..";
  };
}
