{ pkgs, ... }:

{
  imports = [
    ./programs
  ];

  home.stateVersion = "22.11";

  nix.registry.francishamel = {
    from = {
      id = "francishamel";
      type = "indirect";
    };
    to = {
      owner = "francishamel";
      repo = "nix-templates";
      type = "github";
      ref = "main";
    };
  };

  programs = {
    gh.enable = true;

    home-manager.enable = true;

    ssh.enable = true;

    starship.enable = true;

    tmux.enable = true;
  };
}
