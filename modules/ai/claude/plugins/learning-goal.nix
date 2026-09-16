{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      programs.claude-code = {
        marketplaces.learning-goal = pkgs.fetchFromGitHub {
          owner = "DrCatHicks";
          repo = "learning-goal";
          rev = "d459a8b34f47101ab8e4c61ea1360e7a102c1da3";
          hash = "sha256-ap23hX8tEi8kgLpG5QuBX2UWq0RdIXz+pQbOJ4zvS3E=";
        };

        settings.enabledPlugins = {
          "learning-goal@learning-goal" = true;
        };
      };
    };
}
