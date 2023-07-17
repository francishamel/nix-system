{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cachix
    dive
    d2
    flyctl
    yubikey-manager
  ];
}
