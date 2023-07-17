{ self, ... }:

{
  flake = {
    homeModules = {
      common = {
        home.stateVersion = "22.11";
        imports = [
          ./modules/alacritty.nix
          ./modules/bat.nix
          ./modules/direnv.nix
          ./modules/fzf.nix
          ./modules/gh.nix
          ./modules/git.nix
          ./modules/lsd.nix
          ./modules/ssh.nix
          ./modules/starship.nix
          ./modules/terminal.nix
          ./modules/vscode.nix
        ];
      };
      common-darwin.imports = [
        self.homeModules.common
        ./modules/1password/darwin.nix
        ./modules/zsh/darwin.nix
      ];
      common-linux.imports = [
        self.homeModules.common
        ./modules/1password/linux.nix
        ./modules/zsh/linux.nix
      ];
    };
  };
}
