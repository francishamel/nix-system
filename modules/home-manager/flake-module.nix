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
          ./modules/glab.nix
          ./modules/gui.nix
          ./modules/helix.nix
          ./modules/jq.nix
          ./modules/pet.nix
          ./modules/ripgrep.nix
          ./modules/ssh.nix
          ./modules/starship.nix
          ./modules/terminal.nix
          ./modules/vscode.nix
          ./modules/wezterm
          ./modules/yazi.nix
          ./modules/zellij
          ./modules/zoxide.nix
        ];
        home.stateVersion = "22.11";
      };
      x86_64-darwin.imports = [
        ./modules/1password/darwin.nix
        ./modules/zsh/x86_64-darwin.nix
      ];
      aarch64-darwin.imports = [
        ./modules/1password/darwin.nix
        ./modules/zsh/aarch64-darwin.nix
      ];
      x86_64-linux.imports = [
        ./modules/1password/linux.nix
        ./modules/zsh/linux.nix
      ];
    };
  };
}
