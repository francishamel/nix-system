{ lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  inherit (pkgs) stdenv;
in
{
  # Disable last login message
  home.file = mkIf (stdenv.isDarwin) {
    ".hushlogin".text = "";
  };

  programs.zsh = {
    defaultKeymap = "emacs";
    dotDir = ".config/zsh";
    enable = true;
    historySubstringSearch.enable = true;
    shellAliases.".." = "cd ..";
  };
}
