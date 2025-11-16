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
    in
    {
      programs.helix = {
        enable = true;
        defaultEditor = true;
        extraPackages = [
          pkgs.yaml-language-server
        ];
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
