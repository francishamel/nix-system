{ inputs, ... }:

{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      programs.pi-coding-agent = {
        enable = true;
        package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.pi;
        extraPackages = [ pkgs.nodejs ];
        settings = {
          theme = "nord";
          quietStartup = true;
          defaultProjectTrust = "ask";
          defaultProvider = "openai";
          defaultModel = "gpt-5.6-terra";
          defaultThinkingLevel = "medium";
          enableInstallTelemetry = false;
          themes = [ ./pi/nord.json ];
          extensions = [ ./pi/custom-header.ts ];
          packages = [ "npm:pi-permission-modes@2.2.0" ];
        };
      };

      home.file.".pi/agent/permission-mode/permission-mode.json".source = ./pi/permission-mode.json;
    };
}
