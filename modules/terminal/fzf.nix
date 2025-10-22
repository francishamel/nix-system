{ lib, ... }:
{
  flake.modules.homeManager.base =
    { config, pkgs, ... }:
    let
      fd = lib.getExe config.programs.fd.package;
      fileCommand = "${fd} --type=file";
    in
    {
      programs = {
        fzf = {
          enable = true;
          enableZshIntegration = true;
          colors = {
            "bg+" = "#3B4252";
            "bg" = "#2E3440";
            "spinner" = "#81A1C1";
            "hl" = "#616E88";
            "fg" = "#D8DEE9";
            "header" = "#616E88";
            "info" = "#81A1C1";
            "pointer" = "#81A1C1";
            "marker" = "#81A1C1";
            "fg+" = "#D8DEE9";
            "prompt" = "#81A1C1";
            "hl+" = "#81A1C1";
          };
          defaultCommand = fileCommand;
          defaultOptions = [
            "--height=40%"
            "--layout=reverse"
            "--info=inline"
            "--border"
            "--margin=1"
            "--padding=1"
          ];
          fileWidgetCommand = fileCommand;
          changeDirWidgetCommand = "${fd} --type=directory";
        };
        zsh = {
          plugins = [
            {
              name = "fzf-tab";
              src = pkgs.zsh-fzf-tab;
              file = "share/fzf-tab/fzf-tab.plugin.zsh";
            }
          ];
          initContent = ''
            # fzf-tab does not take default options into consideration so we have to set the height directly
            zstyle ':fzf-tab:*' fzf-flags --height=40%
          '';
        };
      };
    };
}


