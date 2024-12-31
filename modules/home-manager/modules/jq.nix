{ pkgs, ... }:

{
  home.packages = [
    pkgs.jqp
  ];

  programs = {
    jq.enable = true;
    zsh.shellAliases.jqp = "jqp --theme nord";
  };
}
