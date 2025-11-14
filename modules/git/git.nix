{ config, ... }:
let
  user = config.flake.meta.user;
in
{
  flake.modules.homeManager.base = {
    programs.git = {
      enable = true;
      settings = {
        alias = {
          commiters = "shortlog --summary --numbered --email";
          print-branch = "rev-parse --abbrev-ref HEAD";
        };
        branch.sort = "-commiterdate";
        column.ui = "auto";
        core.untrackedCache = true;
        diff = {
          algorithm = "histogram";
          colorMoved = true;
          mnemonicPrefix = true;
        };
        fetch.prune = true;
        help.autocorrect = 10;
        init.defaultBranch = "main";
        log.date = "iso";
        merge.conflictstyle = "zdiff3";
        pull.rebase = true;
        push = {
          autoSetupRemote = true;
          default = "current";
          useForceIfIncludes = true;
        };
        rebase = {
          autoStash = true;
          autosquash = true;
          updateRefs = true;
        };
        rerere.enabled = true;
        status.submoduleSummary = true;
        user = {
          email = user.gitEmail;
          name = user.name;
        };
      };
    };
  };
}
