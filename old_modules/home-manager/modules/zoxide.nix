{ ... }:

{
  programs = {
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    zsh.shellAliases.".." = "z ..";
  };
}
