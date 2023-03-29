{ config, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.modules.cli.bat;
in
{
  options.modules.cli.bat.enable = mkEnableOption "Enable personal home-manager module for bat.";

  config = mkIf cfg.enable {
    programs = {
      bat = {
        # TODO: use global theme
        config.theme = "Solarized (dark)";
        enable = true;
      };

      zsh.shellAliases."cat" = "${pkgs.bat}/bin/bat";
    };
  };
}
