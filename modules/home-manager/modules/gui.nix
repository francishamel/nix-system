{ pkgs, ... }:

{
  home.packages = [
    pkgs.discord
    pkgs.postman
    pkgs.slack
  ];
}
