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

            context = # markdown
              ''
                - **NEVER** use `python` or `python3`
                - For JSON, use `jq` (already available). It handles nearly everything.
              '';
          };
        };
      darwin.base.homebrew.casks = [ "claude" ];
    };
  };
}
