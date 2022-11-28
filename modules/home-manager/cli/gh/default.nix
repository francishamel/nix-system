{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.modules.cli.gh;
in
{
  options.modules.cli.gh.enable = mkEnableOption "Enable personal home-manager module for gh.";

  config = mkIf cfg.enable {
    programs.gh = {
      enable = true;
      enableGitCredentialHelper = false;
      settings = {
        aliases = {
          "prc" = "pr create --web --assignee @me";
          "prv" = "pr view --web";
        };
        # TODO: use a param for the editor value
        editor = "code --wait";
        git_protocol = "ssh";
      };
    };
  };
}
