{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      cachix
      dive
      d2
      flyctl
      yubikey-manager
    ];
    stateVersion = "22.11";
  };

  modules = {
    cli = {
      _1password.enable = true;
      alacritty.enable = true;
      bat.enable = true;
      direnv.enable = true;
      fzf.enable = true;
      gh.enable = true;
      git = {
        enable = true;
        userName = "Francis Hamel";
        userEmail = "36383308+francishamel@users.noreply.github.com";
      };
      lsd.enable = true;
      ssh.enable = true;
      zsh.enable = true;
    };
    editor.vscode.enable = true;
  };

  programs = {
    home-manager.enable = true;
    starship.enable = true;
  };
}
