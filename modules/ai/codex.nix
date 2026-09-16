{ inputs, ... }:

{
  flake.modules.homeManager.base =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      programs.codex = {
        enable = true;
        package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.codex;
        settings = {
          approvals_reviewer = "auto_review";
          approval_policy = "on-request";
          sandbox_mode = "workspace-write";

          # config.toml is a read-only store symlink, so codex cannot record
          # trust itself. Declare the trusted directories here instead.
          projects =
            lib.genAttrs
              (map (path: "${config.home.homeDirectory}/src/gh/${path}") [
                "francishamel/nix-system"
                "AtoB-Developers/backend"
              ])
              (_: {
                trust_level = "trusted";
              });
        };
      };
    };
}
