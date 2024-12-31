{ pkgs, ... }:

{
  home.packages = [
    pkgs.discord
    pkgs.slack
  ];
}
