{ config, ... }:

{
  modules = {
    cli = {
      # TODO: is this needed? enable = true;
      bat.enable = true;
      git.enable = true;
      zsh.enable = true;
    };
  };
}
