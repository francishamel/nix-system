{ config, ... }:

{
  modules = {
    cli = {
      # TODO: is this needed? enable = true;
      git.enable = true;
      zsh.enable = true;
    };
  };
}
