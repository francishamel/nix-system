{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.modules.cli.zsh;
in
{
  options.modules.cli.zsh.enable = mkEnableOption "Enable personal home-manager module for Zsh.";

  config = mkIf cfg.enable {
    # Disable last login message
    # TODO: only set if Mac OS.
    home.file.".hushlogin".text = "";

    programs.zsh = {
      defaultKeymap = "emacs";
      dotDir = ".config/zsh";
      enable = true;
      historySubstringSearch.enable = true;
      shellAliases.".." = "cd ..";
    };
  };
}
