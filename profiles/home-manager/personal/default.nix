{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cachix
    dive
    flyctl
    yubikey-manager
  ];

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

  programs.starship.enable = true;
}
