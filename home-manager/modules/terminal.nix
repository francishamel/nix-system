{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cachix
    d2
    yubikey-manager
  ];
}
