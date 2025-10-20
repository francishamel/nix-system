{ ... }:

{
  flake = {
    modules.homeManager = {
      base = {
        imports = [
          ./modules/bat.nix
          ./modules/direnv.nix
          ./modules/eza.nix
          ./modules/fd.nix
          ./modules/fonts.nix
          ./modules/fzf.nix
          ./modules/ghostty.nix
          ./modules/git.nix
          ./modules/helix.nix
          ./modules/jq.nix
          ./modules/ripgrep.nix
          ./modules/starship.nix
          ./modules/terminal.nix
          ./modules/vscode.nix
          ./modules/wezterm
          ./modules/yazi.nix
          ./modules/zathura.nix
          ./modules/zoxide.nix
        ];
        xdg.enable = true;
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
