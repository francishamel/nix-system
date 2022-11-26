{ ... }:

{
  imports = [
    ../../profiles/home-manager
  ];

  home.stateVersion = "22.11";

  programs = {
    home-manager.enable = true;

    starship.enable = true;
  };
}
