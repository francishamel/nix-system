{ config, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.modules.cli.lsd;
in
{
  options.modules.cli.lsd.enable = mkEnableOption "Enable personal home-manager module for lsd.";

  config = mkIf cfg.enable {
    programs = {
      lsd.enable = true;

      zsh.shellAliases = {
        "ll" = "${pkgs.lsd}/bin/lsd -la";
        "ls" = "${pkgs.lsd}/bin/lsd";
        "lt" = "${pkgs.lsd}/bin/lsd --tree";
      };
    };
  };
}
