{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cachix
    d2
    flyctl
    upterm
    yubikey-manager
  ];
}
