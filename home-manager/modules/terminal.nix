{ pkgs, ... }:

{
  home.packages = [
    pkgs.cachix
    pkgs.d2
    pkgs.devenv
    pkgs.flyctl
  ];
}
