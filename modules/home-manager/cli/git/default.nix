{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.modules.cli.git;
in
{
  options.modules.cli.git.enable = mkEnableOption "Enable personal home-manager module for git.";

  config = mkIf cfg.enable {
    programs.git = {
      aliases = { fp = "fetch --prune"; };
      enable = true;
      extraConfig = {
        # TODO: use a param for the editor value
        core.editor = "code --wait";
        init.defaultBranch = "main";
        merge.conflictstyle = "diff3";
        pull.rebase = true;
        rebase = {
          autoStash = true;
          autosquash = true;
        };
      };
      # TODO: parameterize these values
      # TODO: encrypt these values
      userEmail = "francishamel96@gmail.com";
      userName = "Francis Hamel";
    };
  };
}
