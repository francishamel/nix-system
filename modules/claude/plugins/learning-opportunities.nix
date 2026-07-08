{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      programs.claude-code = {
        marketplaces.learning-opportunities = pkgs.fetchFromGitHub {
          owner = "DrCatHicks";
          repo = "learning-opportunities";
          rev = "e5f985d376461993253d285096ed0f4b4a095858";
          hash = "sha256-xMpy9XxMaNCIAOr2dffrc5dyRt56jlam+XQjrNapsEw=";
        };

        settings.enabledPlugins = {
          "learning-opportunities@learning-opportunities" = true;
          "learning-opportunities-auto@learning-opportunities" = true;
          "orient@learning-opportunities" = true;
        };
      };
    };
}
