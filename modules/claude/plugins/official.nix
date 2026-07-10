{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      programs.claude-code = {
        marketplaces.claude-plugins-official = pkgs.fetchFromGitHub {
          owner = "anthropics";
          repo = "claude-plugins-official";
          rev = "5088261e0e51d8d20c7312641a4a772ead0628a8";
          hash = "sha256-ideJZdm5itdFsi4fW+RQT1DKX/6PGYPL5Eatsdikprk=";
        };

        settings.enabledPlugins = {
          "github@claude-plugins-official" = true;
          "linear@claude-plugins-official" = true;
        };
      };
    };
}
