{ ... }:

{
  imports = [
    ../../profiles/home-manager/personal
  ];

  home.stateVersion = "22.11";

  programs = {
    home-manager.enable = true;

    starship.enable = true;
  };
}
