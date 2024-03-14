{ config, ... }:

{
  programs.git = {
    userName = "Francis Hamel";
    userEmail = "36383308+francishamel@users.noreply.github.com";
    aliases = {
      cf = "commit --fixup";
      fp = "fetch --prune";
      pfwl = "push --force-with-lease";
    };
    enable = true;
    extraConfig = {
      core.editor = "codium --wait";
      init.defaultBranch = "main";
      merge.conflictstyle = "diff3";
      pull.rebase = true;
      rebase = {
        autoStash = true;
        autosquash = true;
      };
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = false;
    settings = {
      aliases = {
        "prc" = "pr create --web --assignee @me";
        "prv" = "pr view --web";
        "rc" = "repo clone $1 ${config.home.homeDirectory}/src/$1";
      };
      editor = "codium --wait";
      git_protocol = "ssh";
    };
  };
}
