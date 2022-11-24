{ config, ... }:

{
  modules = {
    cli = {
      bat.enable = true;
      direnv.enable = true;
      gh.enable = true;
      git.enable = true;
      lsd.enable = true;
      zsh.enable = true;
    };
  };
}
