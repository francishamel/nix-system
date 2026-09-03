{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      programs.claude-code = {
        # Not named `claude-plugins-official`: Claude reserves that name for
        # GitHub sources from the `anthropics` org, and `marketplaces.*` always
        # registers a directory source, so the marketplace fails to load.
        marketplaces.official = pkgs.fetchFromGitHub {
          owner = "anthropics";
          repo = "claude-plugins-official";
          rev = "5088261e0e51d8d20c7312641a4a772ead0628a8";
          hash = "sha256-ideJZdm5itdFsi4fW+RQT1DKX/6PGYPL5Eatsdikprk=";
        };

        settings.enabledPlugins = {
          "github@official" = true;
          "linear@official" = true;
        };
      };
    };
}
