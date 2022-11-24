{ config, ... }:

{
  modules = {
    cli = {
      _1password.enable = true;
      bat.enable = true;
      direnv.enable = true;
      fzf.enable = true;
      gh.enable = true;
      git.enable = true;
      lsd.enable = true;
      ssh.enable = true;
      zsh.enable = true;
    };
  };
}
