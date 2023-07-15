{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    extensions = with pkgs.vscode-extensions; [
      pkgs.vscode-extensions."1Password".op-vscode
      alefragnani.project-manager
      bradlc.vscode-tailwindcss
      codezombiech.gitignore
      eamodio.gitlens
      elixir-lsp.vscode-elixir-ls
      gruntfuggly.todo-tree
      jnoortheen.nix-ide
      mkhl.direnv
      pkief.material-icon-theme
    ];
    mutableExtensionsDir = false;
    package = pkgs.vscodium;
    userSettings = {
      "diffEditor.ignoreTrimWhitespace" = false;
      "editor.fontFamily" = "'FiraCode Nerd Font'";
      "editor.fontLigatures" = true;
      "editor.formatOnSave" = true;
      "editor.minimap.enabled" = false;
      "editor.tabSize" = 2;
      "files.insertFinalNewline" = true;
      "git.allowForcePush" = true;
      "git.branchProtection" = [ "main" "master" "trunk" ];
      "git.branchProtectionPrompt" = "alwaysCommitToNewBranch";
      "git.confirmSync" = false;
      "git.pullBeforeCheckout" = true;
      "git.terminalAuthentication" = false;
      "git.untrackedChanges" = "separate";
      "github.gitAuthentication" = false;
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "nix.serverSettings" = {
        "nil" = {
          "formatting" = {
            "command" = [ "nixpkgs-fmt" ];
          };
        };
      };
      "projectManager.git.baseFolders" = [ "~/src" ];
      "telemetry.telemetryLevel" = "off";
      "workbench.colorTheme" = "Solarized Dark";
      "workbench.iconTheme" = "material-icon-theme";
      "workbench.startupEditor" = "none";
    };
  };

  programs.zsh = {
    initExtra = ''
      EDITOR="code --wait"
    '';
    shellAliases = {
      code = "codium";
    };
  };
}
