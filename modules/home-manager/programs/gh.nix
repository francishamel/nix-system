{ ... }:

{
  programs.gh = {
    enable = true;
    enableGitCredentialHelper = false;
    settings = {
      aliases = {
        "prc" = "pr create --web --assignee @me";
        "prv" = "pr view";
      };
      editor = "code --wait";
      git_protocol = "ssh";
    };
  };
}
