{ config, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (pkgs) stdenv;

  cfg = config.modules.cli.zsh;
in
{
  options.modules.cli.zsh.enable = mkEnableOption "Enable personal home-manager module for Zsh.";

  config = mkIf cfg.enable {
    # Disable last login message
    home.file.".hushlogin" = mkIf (stdenv.isDarwin) { text = ""; };

    programs.zsh = {
      defaultKeymap = "emacs";
      dotDir = ".config/zsh";
      enable = true;
      historySubstringSearch.enable = true;
      shellAliases.".." = "cd ..";
    };
  };
}
