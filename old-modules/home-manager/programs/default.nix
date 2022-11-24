{ ... }:

{
  imports = [
    ./1password.nix
    ./alacritty.nix
    ./direnv.nix
    ./fzf.nix
    ./gh.nix
    ./ssh.nix
    ./vscode.nix
    ../../../profiles/home-manager
  ];
}
