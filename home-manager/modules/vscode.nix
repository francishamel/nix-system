{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    extensions = [
      pkgs.vscode-extensions.arcticicestudio.nord-visual-studio-code
      pkgs.vscode-extensions.bradlc.vscode-tailwindcss
      pkgs.vscode-extensions.codezombiech.gitignore
      pkgs.vscode-extensions.eamodio.gitlens
      pkgs.vscode-extensions.elixir-lsp.vscode-elixir-ls
      pkgs.vscode-extensions.gleam.gleam
      pkgs.vscode-extensions.gruntfuggly.todo-tree
      pkgs.vscode-extensions.jnoortheen.nix-ide
      pkgs.vscode-extensions.mkhl.direnv
      pkgs.vscode-extensions.ms-python.python
      pkgs.vscode-extensions.phoenixframework.phoenix
      pkgs.vscode-extensions.pkief.material-icon-theme
      pkgs.vscode-extensions.tamasfe.even-better-toml
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [ ];
    mutableExtensionsDir = false;
    userSettings = {
      "diffEditor.ignoreTrimWhitespace" = false;
      "editor.fontFamily" = "'FiraCode Nerd Font'";
      "editor.fontLigatures" = true;
      "editor.formatOnSave" = true;
      "editor.minimap.enabled" = false;
      "editor.tabSize" = 2;
      "elixirLS.dialyzerEnabled" = false;
      "elixirLS.suggestSpecs" = false;
      "emmet.includeLanguages" = {
        "elixir" = "html";
        "phoenix-heex" = "html";
        "erb" = "html";
      };
      "files.insertFinalNewline" = true;
      "git.allowForcePush" = true;
      "git.branchProtection" = [ "main" "master" "trunk" ];
      "git.branchProtectionPrompt" = "alwaysCommitToNewBranch";
      "git.confirmSync" = false;
      "git.pullBeforeCheckout" = true;
      "git.terminalAuthentication" = false;
      "git.untrackedChanges" = "separate";
      "github.gitAuthentication" = false;
      "gitlens.plusFeatures.enabled" = false;
      "gitlens.showWelcomeOnInstall" = false;
      "gitlens.showWhatsNewAfterUpgrades" = false;
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "nix.serverSettings" = {
        "nil" = {
          "formatting" = {
            "command" = [ "nixpkgs-fmt" ];
          };
        };
      };
      "tailwindCSS.includeLanguages" = {
        "elixir" = "html";
        "phoenix-heex" = "html";
      };
      "telemetry.telemetryLevel" = "off";
      "workbench.colorTheme" = "Nord";
      "workbench.iconTheme" = "material-icon-theme";
      "workbench.startupEditor" = "none";
    };
  };

  programs.zsh = {
    initExtra = ''
      EDITOR="${pkgs.vscode}/bin/code --wait"
    '';
  };
}
