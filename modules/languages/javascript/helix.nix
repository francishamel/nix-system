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
      # There's a fix in 5.1.2, just waiting on nixpkgs to catch up
      typescript-language-server = pkgs.typescript-language-server.overrideAttrs (_: rec {
        version = "5.1.2";
        src = pkgs.fetchFromGitHub {
          owner = "typescript-language-server";
          repo = "typescript-language-server";
          rev = "v${version}";
          hash = "sha256-8UDPeW8Bb6Or+G28GI+fprUtqnDGKTqeWskpn9i0HCA=";
        };
        offlineCache = pkgs.fetchYarnDeps {
          yarnLock = "${src}/yarn.lock";
          hash = "sha256-CSjxiuUN+hHmoWwkVe6c5lLFeX3ROB3QlBQ15rVmPhk=";
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
