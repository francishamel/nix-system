{ config, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.modules.editor.vscode;
in
{
  options.modules.editor.vscode.enable = mkEnableOption "Enable personal home-manager module for VSCode.";

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      extensions = with pkgs.vscode-extensions; [
        pkgs.vscode-extensions."1Password".op-vscode
        alefragnani.project-manager
        codezombiech.gitignore
        eamodio.gitlens
        elixir-lsp.vscode-elixir-ls
        gruntfuggly.todo-tree
        jnoortheen.nix-ide
        mkhl.direnv
        pkief.material-icon-theme
      ];
      mutableExtensionsDir = false;
      userSettings = {
        "diffEditor.ignoreTrimWhitespace" = false;
        # TODO: set this based on theme config
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
        "projectManager.git.baseFolders" = [
          "~/.nixpkgs"
          "~/src"
        ];
        "telemetry.telemetryLevel" = "off";
        "workbench.colorTheme" = "Solarized Dark";
        "workbench.iconTheme" = "material-icon-theme";
      };
    };

    # TODO: use a param for the editor value
    programs.zsh.initExtra = ''
      EDITOR="code --wait"
    '';
  };
}
