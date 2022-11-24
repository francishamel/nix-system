{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.modules.cli.ssh;
in
{
  options.modules.cli.ssh.enable = mkEnableOption "Enable personal home-manager module for ssh.";

  config = mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      hashKnownHosts = true;
    };
  };
}
