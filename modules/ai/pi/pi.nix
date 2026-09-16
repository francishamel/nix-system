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
          defaultProvider = "openai-codex";
          defaultModel = "gpt-5.6-terra";
          defaultThinkingLevel = "medium";
          enableInstallTelemetry = false;
          themes = [ ./nord.json ];
          extensions = [ ./custom-header.ts ];
        };
      };
    };
}
