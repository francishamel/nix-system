{ config, lib, ... }:
let
  user = config.flake.meta.user;
in
{
  flake.modules.homeManager.base =
    { config, ... }:
    {
      programs = {
        git = {
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

        lazygit = {
          enable = true;
          settings = {
            git = {
              overrideGpg = true;
              pagers = [{
                pager = "${lib.getExe config.programs.delta.package} --dark --paging=never --line-numbers --hyperlinks --hyperlinks-file-link-format=\"lazygit-edit://{path}:{line}\"";
              }];
              skipHookPrefix = "fixup!";
            };
            gui.nerdFontsVersion = "3";
          };
        };

        zsh.shellAliases.lg = lib.getExe config.programs.lazygit.package;
      };
    };
}
