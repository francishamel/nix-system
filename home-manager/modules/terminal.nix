{ pkgs, ... }:

{
  home.packages = [
    pkgs.cachix
    pkgs.d2
    pkgs.flyctl
    pkgs.upterm
    pkgs.yubikey-manager
  ];
}
