{ lib, ... }:
{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    let
      prettierFormatter = {
        command = lib.getExe pkgs.prettier;
        args = [
          "--parser"
          "typescript"
        ];
      };
      # Temporary fix for LSP issue
      # https://github.com/helix-editor/helix/issues/14738
      # https://github.com/typescript-language-server/typescript-language-server/issues/1014
      typescript-language-server = pkgs.typescript-language-server.overrideAttrs (_: rec {
        version = "5.0.1";
        src = pkgs.fetchFromGitHub {
          owner = "typescript-language-server";
          repo = "typescript-language-server";
          rev = "v5.0.1";
          hash = "sha256-Ziiiw6MXoIa1bWtME7dvzg+kQ8iXMG3P5rNR1B/Iifg=";
        };
        offlineCache = pkgs.fetchYarnDeps {
          yarnLock = "${src}/yarn.lock";
          hash = "sha256-ODO1G1AJd38cGqHhau1t4D8Mrug44pLk36d9dGtb/nM=";
        };
      });
    in
    {
      programs.helix = {
        extraPackages = [
          pkgs.prettier
          typescript-language-server
        ];
        languages.language = [
          {
            name = "javascript";
            auto-format = true;
            formatter = prettierFormatter;
          }
          {
            name = "typescript";
            auto-format = true;
            formatter = prettierFormatter;
          }
          {
            name = "tsx";
            auto-format = true;
            formatter = prettierFormatter;
          }
        ];
      };
    };
}
