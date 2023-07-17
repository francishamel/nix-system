{ pkgs, ... }:

{
  programs = {
    bat = {
      config.theme = "Solarized (dark)";
      enable = true;
    };

    zsh.shellAliases."cat" = "${pkgs.bat}/bin/bat";
  };
}
