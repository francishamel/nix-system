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
        # TODO: find a way to centralize secrets
        userName = "op://macbook-nix/personal/git/userName";
        userEmail = "op://macbook-nix/personal/git/userEmail";
      };
      lsd.enable = true;
      ssh.enable = true;
      zsh.enable = true;
    };
    editor.vscode.enable = true;
  };
}
