{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      _1Password.op-vscode
      alefragnani.project-manager
      bierner.markdown-mermaid
      codezombiech.gitignore
      eamodio.gitlens
      foam.foam-vscode
      jnoortheen.nix-ide
      pkief.material-icon-theme
      redhat.vscode-yaml
      yzhang.markdown-all-in-one
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
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "nix.serverSettings.nil.formatting.command" = [ "nixpkgs-fmt" ];
      "projectManager.git.baseFolders" = [ "~/.nixpkgs" "~/src" ];
      "redhat.telemetry.enabled" = false;
      "telemetry.telemetryLevel" = "off";
      "update.mode" = "none";
      "workbench.colorTheme" = "Solarized Dark";
      "workbench.iconTheme" = "material-icon-theme";
    };
  };
}
