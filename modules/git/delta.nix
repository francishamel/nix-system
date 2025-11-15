{ lib, ... }:
{
  flake.modules.homeManager.base =
    { config, pkgs, ... }:
    {
      programs = {
        delta = {
          enable = true;
          enableGitIntegration = true;
          options = {
            line-numbers = true;
            navigate = true;
            side-by-side = true;
            features = "arctic-fox";
          };
        };

        git.settings.include.path = "delta/themes.gitconfig";

        lazygit.settings.git.pagers = [
          {
            pager = "${lib.getExe config.programs.delta.package} --dark --paging=never --line-numbers --hyperlinks --hyperlinks-file-link-format=\"lazygit-edit://{path}:{line}\"";
          }
        ];
      };

      # delta themes config
      xdg.configFile."git/delta/themes.gitconfig" = {
        source = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/dandavison/delta/ef3e1be569bf076f035327342939bd9d7c8908bd/themes.gitconfig";
          sha256 = "sha256-NBALeGfKhgDbCqzBVirC0886P0CCVvAH3Pf3NvVg4KM=";
        };
      };
    };
}
