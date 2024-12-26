{ pkgs, ... }:

{
  home.packages = [ pkgs.repgrep ];

  programs.ripgrep.enable = true;
}
