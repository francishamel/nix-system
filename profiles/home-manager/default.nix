{ config, ... }:

{
  modules = {
    cli = {
      # TODO: is this needed? enable = true;
      zsh.enable = true;
    };
  };
}
