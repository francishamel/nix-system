{ ... }:

{
  home.stateVersion = "22.11";

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  programs = {
    home-manager.enable = true;

    starship.enable = true;
  };
}
