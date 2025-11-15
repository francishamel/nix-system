{ lib, ... }:
{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    let
      noopKeys = {
        up = "no_op";
        down = "no_op";
        left = "no_op";
        right = "no_op";
        pageup = "no_op";
        pagedown = "no_op";
        home = "no_op";
        end = "no_op";
      };
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
        enable = true;
        defaultEditor = true;
        # TODO: languages concern
        extraPackages = [
          pkgs.elixir-ls
          pkgs.gleam
          pkgs.llvmPackages_21.clang-tools
          pkgs.lua-language-server
          pkgs.markdown-oxide
          pkgs.marksman
          pkgs.nil
          pkgs.nixd
          pkgs.prettier
          pkgs.python312Packages.python-lsp-server
          pkgs.taplo
          pkgs.tinymist
          typescript-language-server
          pkgs.yaml-language-server
        ];
        # TODO: languages concern
        languages = {
          language-server.nixd.command = lib.getExe pkgs.nixd;
          language = [
            {
              name = "cpp";
              auto-format = true;
              formatter.command = lib.getExe' pkgs.llvmPackages_21.clang-tools "clang-format";
            }
            {
              name = "nix";
              auto-format = true;
              formatter.command = lib.getExe pkgs.nixfmt;
              language-servers = [
                "nixd"
                "nil"
              ];
            }
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
            {
              name = "json";
              auto-format = true;
              formatter = {
                command = lib.getExe pkgs.prettier;
                args = [
                  "--parser"
                  "json"
                ];
              };
            }
            {
              name = "typst";
              auto-format = true;
              formatter.command = lib.getExe pkgs.typstyle;
            }
          ];
        };
        settings = {
          editor = {
            bufferline = "always";
            color-modes = true;
            cursor-shape = {
              insert = "bar";
              normal = "block";
              select = "underline";
            };
            line-number = "relative";
            middle-click-paste = false;
            mouse = false;
            rulers = [ 120 ];
            statusline = {
              mode = {
                normal = "NORMAL";
                insert = "INSERT";
                select = "SELECT";
              };
            };
          };
          keys = {
            normal = {
              "X" = "select_line_above";
              "C-j" = [
                "extend_to_line_bounds"
                "delete_selection"
                "paste_after"
              ];
              "C-k" = [
                "extend_to_line_bounds"
                "delete_selection"
                "move_line_up"
                "paste_before"
              ];
            }
            // noopKeys;
            insert = { } // noopKeys;
          };
          # TODO: styling concern
          theme = "nord";
        };
      };
    };
}
