{ inputs, ... }:

{
  flake.modules.homeManager.base =
    { config, pkgs, ... }:
    {
      programs.pi-coding-agent = {
        enable = true;
        package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.pi;
        settings.theme = "nord";
      };

      home.file."${config.programs.pi-coding-agent.configDir}/themes/nord.json".source = ./pi/nord.json;
    };
}
