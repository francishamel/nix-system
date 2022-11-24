{ config, ... }:

{
  modules = {
    cli = {
      # TODO: is this needed? enable = true;
      bat.enable = true;
      direnv.enable = true;
      git.enable = true;
      lsd.enable = true;
      zsh.enable = true;
    };
  };
}
