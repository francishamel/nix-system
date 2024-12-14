{ config, pkgs, ... }:

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
        "print-branch" = "rev-parse --abbrev-ref HEAD";
      };
      enable = true;
      extraConfig = {
        fetch.prune = true;
        init.defaultBranch = "main";
        merge.conflictstyle = "zdiff3";
        pull.rebase = true;
        rebase = {
          autoStash = true;
          autosquash = true;
          updateRefs = true;
        };
        rerere.enabled = true;
      };
      delta = {
        enable = true;
        options = {
          line-numbers = true;
          navigate = true;
          side-by-side = true;
          theme = "Nord";
        };
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
          "prd" = "pr create --draft --assignee @me";
          "prv" = "pr view --web";
          "rc" = "repo clone $1 ${config.home.homeDirectory}/src/$1";
        };
        git_protocol = "ssh";
      };
    };

    lazygit = {
      enable = true;
      settings = {
        git = {
          paging.pager = "${config.programs.git.delta.package}/bin/delta --dark --paging=never";
          overrideGpg = true;
        };
        gui.nerdFontsVersion = "3";
      };
    };

    zsh.shellAliases.lg = "${pkgs.lazygit}/bin/lazygit";
  };
}
