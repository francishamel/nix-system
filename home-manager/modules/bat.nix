{ pkgs, ... }:

{
  programs = {
    bat = {
      enable = true;
      config.theme = "Nord";
    };

    zsh.shellAliases."cat" = "${pkgs.bat}/bin/bat";
  };
}
