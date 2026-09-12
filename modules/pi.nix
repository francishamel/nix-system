{ inputs, ... }:

{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      programs.pi-coding-agent = {
        enable = true;
        package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.pi;
        settings = {
          theme = "nord";
          quietStartup = true;
          themes = [ ./pi/nord.json ];
          extensions = [ ./pi/custom-header.ts ];
        };
      };
    };
}
