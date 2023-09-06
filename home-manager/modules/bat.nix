{ pkgs, ... }:

{
  programs = {
    bat.enable = true;

    zsh.shellAliases."cat" = "${pkgs.bat}/bin/bat";
  };
}
