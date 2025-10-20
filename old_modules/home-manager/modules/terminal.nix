{ pkgs, ... }:

{
  home.packages = [
    pkgs.cachix
    pkgs.d2
    pkgs.devenv
    pkgs.flyctl
    pkgs.glances
    pkgs.glow
    pkgs.google-cloud-sdk
    pkgs.just
    pkgs.tokei
    pkgs.xh
  ];
}
