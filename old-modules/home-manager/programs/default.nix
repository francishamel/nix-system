{ ... }:

{
  imports = [
    ./1password.nix
    ./alacritty.nix
    ./bat.nix
    ./direnv.nix
    ./fzf.nix
    ./gh.nix
    ./git.nix
    ./lsd.nix
    ./ssh.nix
    ./vscode.nix
    ./zsh.nix
    ../../../profiles/home-manager
  ];
}
