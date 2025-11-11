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
      prettier = lib.getExe pkgs.prettier;
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
          pkgs.typescript-language-server
          pkgs.yaml-language-server
        ];
        # TODO: languages concern
        # TODO: use lib.getExe and lib.getExe' to set commands properly
        languages = {
          language-server.nixd.command = "${pkgs.nixd}/bin/nixd";
          language = [
            {
              name = "cpp";
              auto-format = true;
              formatter.command = "${pkgs.llvmPackages_21.clang-tools}/bin/clang-format";
            }
            {
              name = "nix";
              auto-format = true;
              formatter.command = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt";
              language-servers = [ "nixd" "nil" ];
            }
            {
              name = "javascript";
              auto-format = true;
              formatter = {
                command = prettier;
                args = [
                  "--parser"
                  "typescript"
                ];
              };
            }
            {
              name = "typescript";
              auto-format = true;
              formatter = {
                command = prettier;
                args = [
                  "--parser"
                  "typescript"
                ];
              };
            }
            {
              name = "tsx";
              auto-format = true;
              formatter = {
                command = prettier;
                args = [
                  "--parser"
                  "typescript"
                ];
              };
            }
            {
              name = "json";
              auto-format = true;
              formatter = {
                command = prettier;
                args = [
                  "--parser"
                  "json"
                ];
              };
            }
            {
              name = "typst";
              auto-format = true;
              formatter.command = "${pkgs.typstyle}/bin/typstyle";
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
              "C-j" = [ "extend_to_line_bounds" "delete_selection" "paste_after" ];
              "C-k" = [ "extend_to_line_bounds" "delete_selection" "move_line_up" "paste_before" ];
            } // noopKeys;
            insert = { } // noopKeys;
          };
          # TODO: styling concern
          theme = "nord";
        };
      };
    };
}
