{ pkgs, ... }:

{
  home.packages = with pkgs; [ zsh-fzf-tab ];

  programs.zsh.initExtra = ''
    source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
  '';

  programs.fzf.enable = true;
}
