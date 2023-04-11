{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf mkOption types;

  cfg = config.modules.cli.git;
in
{
  options = {
    modules.cli.git = {
      enable = mkEnableOption "Enable personal home-manager module for git.";

      userName = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Default user name to use.";
      };

      userEmail = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Default user email to use.";
      };
    };
  };

  config = mkIf cfg.enable {
    programs.git = {
      inherit (cfg) userName userEmail;
      aliases = { fp = "fetch --prune"; };
      enable = true;
      extraConfig = {
        core.editor = "code --wait";
        init.defaultBranch = "main";
        merge.conflictstyle = "diff3";
        pull.rebase = true;
        rebase = {
          autoStash = true;
          autosquash = true;
        };
      };
    };
  };
}
