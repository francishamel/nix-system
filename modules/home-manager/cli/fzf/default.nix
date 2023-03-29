{ config, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.modules.cli.fzf;
in
{
  options.modules.cli.fzf.enable = mkEnableOption "Enable personal home-manager module for fzf.";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ zsh-fzf-tab ];

    programs.zsh.initExtra = ''
      source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
    '';

    programs.fzf = {
      enable = true;
      # TODO: only set this if zsh is enabled
      enableZshIntegration = true;
    };
  };
}
