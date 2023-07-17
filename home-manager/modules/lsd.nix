{ pkgs, ... }:

{
  programs = {
    lsd.enable = true;

    zsh.shellAliases = {
      "ll" = "${pkgs.lsd}/bin/lsd -la";
      "ls" = "${pkgs.lsd}/bin/lsd";
      "lt" = "${pkgs.lsd}/bin/lsd --tree";
    };
  };
}
