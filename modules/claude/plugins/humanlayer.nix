{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      programs.claude-code = {
        marketplaces.humanlayer = pkgs.fetchFromGitHub {
          owner = "humanlayer";
          repo = "skills";
          rev = "3c2629142c5d437428269b1b722b08c0b87f574d";
          hash = "sha256-lJvu9CGAN/+dzmzck0CodRXn/p7GUkCbfyZxys4nIoU=";
        };

        settings.enabledPlugins = {
          "show-me@humanlayer" = true;
        };
      };
    };
}
