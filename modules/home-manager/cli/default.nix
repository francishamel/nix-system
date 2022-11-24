{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.modules.cli;
in
{
  imports = [
  ];

  # TODO: is this needed?
  options = {
    modules.cli.enable = mkEnableOption "Enable home-manager configuration of user shells.";
  };

  # TODO: is this needed + should I put something in there?
  config = mkIf cfg.enable { };
}
