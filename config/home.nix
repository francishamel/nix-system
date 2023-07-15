{ pkgs, ... }:

{
  imports = import ./home/list.nix;

  home = {
    packages = with pkgs;
      [
        cachix
        dive
        d2
        flyctl
        yubikey-manager
      ];
    stateVersion = "22.11";
  };

  programs = {
    home-manager.enable = true;
    starship.enable = true;
  };
}
