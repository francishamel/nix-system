{ self, ... }:

{
  flake = {
    homeModules = {
      common = {
        home.stateVersion = "22.11";
        imports = [
          ./alacritty.nix
          ./bat.nix
          ./direnv.nix
          ./fzf.nix
          ./gh.nix
          ./git.nix
          ./lsd.nix
          ./ssh.nix
          ./starship.nix
          ./terminal.nix
          ./vscode.nix
        ];
      };
      common-darwin.imports = [
        self.homeModules.common
        ./1password/darwin.nix
        ./zsh/darwin.nix
      ];
      common-linux.imports = [
        self.homeModules.common
        ./1password/linux.nix
        ./zsh/linux.nix
      ];
    };
  };
}
