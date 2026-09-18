{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      programs = {
        delta.options.features = "arctic-fox";

        git.settings.include.path = "delta/themes.gitconfig";
      };

      xdg.configFile."git/delta/themes.gitconfig" = {
        source = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/dandavison/delta/ef3e1be569bf076f035327342939bd9d7c8908bd/themes.gitconfig";
          sha256 = "sha256-NBALeGfKhgDbCqzBVirC0886P0CCVvAH3Pf3NvVg4KM=";
        };
      };
    };
}
