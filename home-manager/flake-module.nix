{ self, ... }:

{
  flake = {
    homeModules = {
      common = {
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
          ./modules/stylix.nix
          ./modules/terminal.nix
          ./modules/vscode.nix
        ];
      };
      darwin.imports = [
        self.homeModules.common
        ./modules/1password/darwin.nix
        ./modules/zsh/darwin.nix
      ];
      linux.imports = [
        self.homeModules.common
        ./modules/1password/linux.nix
        ./modules/zsh/linux.nix
      ];
    };
  };
}
