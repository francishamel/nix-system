{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      alefragnani.project-manager
      eamodio.gitlens
      jnoortheen.nix-ide
      pkief.material-icon-theme
      redhat.vscode-yaml
    ];
    userSettings = {
      "diffEditor.ignoreTrimWhitespace" = false;
      "editor.fontFamily" = "'FiraCode Nerd Font'";
      "editor.fontLigatures" = true;
      "editor.formatOnSave" = true;
      "editor.minimap.enabled" = false;
      "editor.tabSize" = 2;
      "elixirLS.dialyzerEnabled" = false;
      "elixirLS.suggestSpecs" = false;
      "extensions.autoUpdate" = false;
      "files.insertFinalNewline" = true;
      "git.allowForcePush" = true;
      "git.branchProtection" = [ "main" "master" "trunk" ];
      "git.branchProtectionPrompt" = "alwaysCommitToNewBranch";
      "git.confirmSync" = false;
      "git.experimental.mergeEditor" = true;
      "git.terminalAuthentication" = false;
      "git.untrackedChanges" = "separate";
      "github.gitAuthentication" = false;
      "githubPullRequests.pushBranch" = "always";
      "projectManager.git.baseFolders" = [ "~/.nixpkgs" "~/src" ];
      "redhat.telemetry.enabled" = false;
      "telemetry.telemetryLevel" = "off";
      "update.mode" = "none";
      "workbench.colorTheme" = "Solarized Dark";
      "workbench.iconTheme" = "material-icon-theme";
    };
  };
}
