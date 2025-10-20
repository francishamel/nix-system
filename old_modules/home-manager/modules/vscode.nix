{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = [
        pkgs.vscode-extensions.arcticicestudio.nord-visual-studio-code
        pkgs.vscode-extensions.jnoortheen.nix-ide
        pkgs.vscode-extensions.mkhl.direnv
        pkgs.vscode-extensions.pkief.material-icon-theme
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [ ];
      userSettings = {
        "diffEditor.ignoreTrimWhitespace" = false;
        "editor.accessibilitySupport" = "off";
        "editor.fontFamily" = "'FiraCode Nerd Font'";
        "editor.fontLigatures" = true;
        "editor.formatOnSave" = true;
        "editor.minimap.enabled" = false;
        "editor.tabSize" = 2;
        "files.insertFinalNewline" = true;
        "git.enabled" = false;
        "telemetry.telemetryLevel" = "off";
        "terminal.integrated.macOptionIsMeta" = true;
        "workbench.colorTheme" = "Nord";
        "workbench.iconTheme" = "material-icon-theme";
        "workbench.startupEditor" = "none";
      };
    };

  };
}
