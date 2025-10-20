{
  flake.modules.homeManager.base = {
    programs = {
      zoxide = {
        enable = true;
        enableZshIntegration = true;
      };

      zsh.shellAliases.".." = "z ..";
    };
  };
}
