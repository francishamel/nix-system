{ config, ... }:
let
  user = config.flake.meta.user;
in
{
  flake.modules.homeManager.base =
    { config, ... }:
    {
      gh = {
        enable = true;
        gitCredentialHelper.enable = false;
        settings = {
          aliases = {
            "prc" = "pr create --web --assignee @me";
            "prv" = "pr view --web";
            "rc" = "repo clone $1 ${config.home.homeDirectory}/src/gh/$1";
            "rcme" = "repo clone $1 ${config.home.homeDirectory}/src/gh/${user.githubUsername}/$1";
          };
          git_protocol = "ssh";
        };
      };
    };
}
