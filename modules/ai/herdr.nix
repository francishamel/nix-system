{ inputs, ... }:

{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      programs.herdr = {
        enable = true;
        package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.herdr;
      };
    };
}
