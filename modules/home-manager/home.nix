{ pkgs, ... }:

{
  imports = [
    ./programs
  ];

  home.stateVersion = "22.11";

  programs = {
    gh.enable = true;

    home-manager.enable = true;

    starship.enable = true;
  };
}
