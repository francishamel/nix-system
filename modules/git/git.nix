{ lib, ... }:
{
  flake.modules.homeManager.base =
    { config, pkgs, ... }:
    {
      programs = {
        git = {
          enable = true;
          settings = {
            alias = {
              ca = "commit --amend --no-edit";
              cae = "commit --amend";
              cf = "commit --fixup";
              commiters = "shortlog --summary --numbered --email";
              fp = "fetch --prune";
              pfwl = "push --force-with-lease";
              ri = "rebase --interactive";
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
              email = "36383308+francishamel@users.noreply.github.com";
              name = "Francis Hamel";
            };
          };
        };

        delta = {
          enable = true;
          enableGitIntegration = true;
          options = {
            line-numbers = true;
            navigate = true;
            side-by-side = true;
          };
        };

        gh = {
          enable = true;
          gitCredentialHelper.enable = false;
          settings = {
            aliases = {
              "ic" = "issue create --web";
              "id" = "!gh issue develop $1 --base=\"$(git print-branch)\" --checkout";
              "il" = "issue list";
              "prc" = "pr create --web --assignee @me";
              "prd" = "pr create --draft --assignee @me";
              "prv" = "pr view --web";
              "rc" = "repo clone $1 ${config.home.homeDirectory}/src/gh/$1";
              "rcme" = "repo clone $1 ${config.home.homeDirectory}/src/gh/francishamel/$1";
            };
            git_protocol = "ssh";
          };
        };

        lazygit = {
          enable = true;
          settings = {
            git = {
              overrideGpg = true;
              paging.pager = "${lib.getExe config.programs.delta.package} --dark --paging=never";
              skipHookPrefix = "fixup!";
            };
            gui.nerdFontsVersion = "3";
          };
        };

        zsh.shellAliases.lg = lib.getExe config.programs.lazygit.package;
      };

      # delta themes config
      xdg.configFile."git/delta/themes.gitconfig" = {
        source = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/dandavison/delta/ef3e1be569bf076f035327342939bd9d7c8908bd/themes.gitconfig";
          sha256 = "sha256-NBALeGfKhgDbCqzBVirC0886P0CCVvAH3Pf3NvVg4KM=";
        };
      };
      programs.git.settings.include.path = "delta/themes.gitconfig";
      programs.delta.options.features = "arctic-fox";
    };
}
