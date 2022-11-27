{ ... }:

{
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
        userEmail = "francishamel96@gmail.com";
      };
      lsd.enable = true;
      ssh.enable = true;
      zsh.enable = true;
    };
    editor.vscode.enable = true;
  };
}
