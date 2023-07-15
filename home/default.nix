{ self, ... }:

{
  flake = {
    homeModules = {
      common = {
        home.stateVersion = "22.11";
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
          ./terminal.nix
          ./vscode.nix
          ./zsh.nix
        ];
      };
      common-darwin.imports = [ self.homeModules.common ];
      common-linux.imports = [ self.homeModules.common ];
    };
  };
}
