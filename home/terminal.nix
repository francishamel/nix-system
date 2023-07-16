{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cachix
    # dive
    # d2
    flyctl
    yubikey-manager
  ];
  programs = {
    home-manager.enable = true;
    starship.enable = true;
  };
}
