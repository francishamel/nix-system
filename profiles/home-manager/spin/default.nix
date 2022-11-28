{ ... }:

{
  modules = {
    cli = {
      bat.enable = true;
      fzf.enable = true;
      git.enable = true;
      lsd.enable = true;
      zsh.enable = true;
    };
  };

  programs.zsh.initExtra = ''
    source /etc/zsh/zshrc.default.inc.zsh
  '';
}
