{ config, ... }:

{
  programs.gh = {
    enable = true;
    enableGitCredentialHelper = false;
    settings = {
      aliases = {
        "prc" = "pr create --web --assignee @me";
        "prv" = "pr view --web";
        "rc" = "repo clone $1 ${config.home.homeDirectory}/src/$1";
      };
      editor = "code --wait";
      git_protocol = "ssh";
    };
  };
}
