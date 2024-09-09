{ config, ... }:

{
  programs = {
    git = {
      userName = "Francis Hamel";
      userEmail = "36383308+francishamel@users.noreply.github.com";
      aliases = {
        ca = "commit --amend --no-edit";
        cae = "commit --amend";
        cf = "commit --fixup";
        fp = "fetch --prune";
        pfwl = "push --force-with-lease";
        ri = "rebase --interactive";
      };
      enable = true;
      extraConfig = {
        init.defaultBranch = "main";
        merge.conflictstyle = "diff3";
        pull.rebase = true;
        rebase = {
          autoStash = true;
          autosquash = true;
        };
        rerere.enabled = true;
      };
    };

    gh = {
      enable = true;
      gitCredentialHelper.enable = false;
      settings = {
        aliases = {
          "ic" = "issue create --web";
          "id" = "issue develop $1 --checkout";
          "il" = "issue list";
          "prc" = "pr create --web --assignee @me";
          "prv" = "pr view --web";
          "rc" = "repo clone $1 ${config.home.homeDirectory}/src/$1";
        };
        git_protocol = "ssh";
      };
    };

    lazygit.enable = true;
  };
}
