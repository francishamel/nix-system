{ pkgs, ... }:

{
  imports = [
    ./programs
  ];

  home = {
    packages = with pkgs; [ treefmt ];
    stateVersion = "22.11";
  };

  programs = {
    gh.enable = true;

    home-manager.enable = true;

    ssh.enable = true;

    starship.enable = true;

    tmux.enable = true;
  };
}
