{ config, pkgs, ... }:

{
  imports = [
    ./1password.nix
    ./alacritty.nix
    ./bat.nix
    ./direnv.nix
    ./git.nix
    ./lsd.nix
    ./vscode.nix
    ./zsh.nix
  ];

  home = {
    packages = with pkgs; [ nixpkgs-fmt ];
    stateVersion = "22.11";
  };

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
