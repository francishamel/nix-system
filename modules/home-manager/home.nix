{ pkgs, ... }:

{
  imports = [
    ./programs
  ];

  home.stateVersion = "22.11";

  programs = {
    home-manager.enable = true;

    starship.enable = true;
  };
}
