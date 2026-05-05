{ inputs, ... }:
{
  nix.settings = {
    extra-substituters = [ "https://cache.numtide.com" ];
    extra-trusted-public-keys = [ "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g=" ];
  };

  flake = {
    modules = {
      homeManager.base =
        { pkgs, ... }:
        {
          programs.claude-code = {
            enable = true;
            package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.claude-code;

            marketplaces = {
              learning-opportunities = pkgs.fetchFromGitHub {
                owner = "DrCatHicks";
                repo = "learning-opportunities";
                rev = "e5f985d376461993253d285096ed0f4b4a095858";
                hash = "sha256-xMpy9XxMaNCIAOr2dffrc5dyRt56jlam+XQjrNapsEw=";
              };
              learning-goal = pkgs.fetchFromGitHub {
                owner = "DrCatHicks";
                repo = "learning-goal";
                rev = "d459a8b34f47101ab8e4c61ea1360e7a102c1da3";
                hash = "sha256-ap23hX8tEi8kgLpG5QuBX2UWq0RdIXz+pQbOJ4zvS3E=";
              };
            };

            settings.enabledPlugins = {
              "learning-opportunities@learning-opportunities" = true;
              "learning-opportunities-auto@learning-opportunities" = true;
              "orient@learning-opportunities" = true;
              "learning-goal@learning-goal" = true;
            };
          };
        };
      darwin.base.homebrew.casks = [ "claude" ];
    };
  };
}
