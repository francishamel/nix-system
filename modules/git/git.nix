{ config, lib, ... }:
let
  user = config.flake.meta.user;
in
{
  flake.modules.homeManager.base =
    { config, pkgs, ... }:
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
              "prc" = "pr create --web --assignee @me";
              "prv" = "pr view --web";
              "rc" = "repo clone $1 ${config.home.homeDirectory}/src/gh/$1";
              "rcme" = "repo clone $1 ${config.home.homeDirectory}/src/gh/${user.username}/$1";
            };
            git_protocol = "ssh";
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
