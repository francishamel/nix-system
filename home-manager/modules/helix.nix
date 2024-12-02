{ config, lib, pkgs, ... }:

let
  yaziPicker = pkgs.writeShellScriptBin "yazi-picker" ''
    paths=$(${pkgs.yazi}/bin/yazi --chooser-file=/dev/stdout | while read -r; do printf "%q " "$REPLY"; done)

    if [[ -n "$paths" ]]; then
    	${pkgs.zellij}/bin/zellij action toggle-floating-panes
    	${pkgs.zellij}/bin/zellij action write 27 # send <Escape> key
    	${pkgs.zellij}/bin/zellij action write-chars ":open $paths"
    	${pkgs.zellij}/bin/zellij action write 13 # send <Enter> key
    	${pkgs.zellij}/bin/zellij action toggle-floating-panes
    fi

    ${pkgs.zellij}/bin/zellij action close-pane
  '';
in
{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = [
      pkgs.elixir-ls
      pkgs.gleam
      pkgs.lua-language-server
      pkgs.python312Packages.python-lsp-server
      pkgs.taplo
      pkgs.typescript-language-server
      pkgs.yaml-language-server
    ];
    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt";
        }
      ];
    };
    settings = {
      editor = {
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        line-number = "relative";
        middle-click-paste = false;
        mouse = false;
        rulers = [ 120 ];
      };
      keys = {
        normal = {
          "C-y" = lib.mkIf (config.programs.yazi.enable && config.programs.zellij.enable) ":sh ${pkgs.zellij}/bin/zellij run -f -n yazi-picker -x 10% -y 10% --width 80% --height 80% -- ${yaziPicker}/bin/yazi-picker";
        };
        insert = {
          up = "no_op";
          down = "no_op";
          left = "no_op";
          right = "no_op";
          pageup = "no_op";
          pagedown = "no_op";
          home = "no_op";
          end = "no_op";
        };
      };
      theme = "nord";
    };
  };
}
