{ inputs, ... }:
{
  nix.settings = {
    substituters = [ "https://cache.numtide.com" ];
    trusted-public-keys = [ "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g=" ];
  };

  flake = {
    modules = {
      homeManager.base =
        { pkgs, ... }:
        {
          home.packages = [ inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.claude-code ];
        };
      darwin.base.homebrew.casks = [ "claude" ];
    };
  };
}
