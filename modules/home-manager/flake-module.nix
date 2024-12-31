{ ... }:

{
  flake = {
    homeModules = {
      common = {
        imports = [
          ./modules/alacritty.nix
          ./modules/bat.nix
          ./modules/direnv.nix
          ./modules/eza.nix
          ./modules/fd.nix
          ./modules/fonts.nix
          ./modules/fzf.nix
          ./modules/git.nix
          ./modules/gui.nix
          ./modules/helix.nix
          ./modules/jq.nix
          ./modules/pet.nix
          ./modules/ripgrep.nix
          ./modules/ssh.nix
          ./modules/starship.nix
          ./modules/terminal.nix
          ./modules/vscode.nix
          ./modules/wezterm.nix
          ./modules/yazi.nix
          ./modules/zellij.nix
          ./modules/zoxide.nix
        ];
        home.stateVersion = "22.11";
      };
      darwin-x86-64.imports = [
        ./modules/1password/darwin.nix
        ./modules/zsh/darwin-x86-64.nix
      ];
      darwin-aarch64.imports = [
        ./modules/1password/darwin.nix
        ./modules/zsh/darwin-aarch64.nix
      ];
      x86_64-linux.imports = [
        ./modules/1password/linux.nix
        ./modules/zsh/linux.nix
      ];
    };
  };
}
