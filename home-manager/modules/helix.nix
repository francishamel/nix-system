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
      editor.line-number = "relative";
      keys.normal = {
        "C-y" = lib.mkIf config.programs.yazi.enable ":sh ${pkgs.zellij}/bin/zellij run -f -n yazi-picker -x 10% -y 10% --width 80% --height 80% -- ${yaziPicker}/bin/yazi-picker";
      };
    };
  };
}
