{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.modules.cli.direnv;
in
{
  options.modules.cli.direnv.enable = mkEnableOption "Enable personal home-manager module for direnv.";

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      # TODO: set this using a param
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
