{ ... }:

{
  flake = {
    homeModules = {
      common = {
        imports = [
          ./modules/alacritty.nix
          ./modules/bat.nix
          ./modules/direnv.nix
          ./modules/fzf.nix
          ./modules/git.nix
          ./modules/helix.nix
          ./modules/lsd.nix
          ./modules/ssh.nix
          ./modules/starship.nix
          ./modules/stylix.nix
          ./modules/terminal.nix
          ./modules/vscode.nix
          ./modules/zellij.nix
        ];
        home.stateVersion = "22.11";
      };
      darwin.imports = [
        ./modules/1password/darwin.nix
        ./modules/zsh/darwin.nix
      ];
      linux.imports = [
        ./modules/1password/linux.nix
        ./modules/zsh/linux.nix
      ];
    };
  };
}
