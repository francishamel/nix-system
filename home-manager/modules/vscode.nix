{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    extensions = with pkgs.vscode-extensions; [
      arcticicestudio.nord-visual-studio-code
      bradlc.vscode-tailwindcss
      codezombiech.gitignore
      eamodio.gitlens
      elixir-lsp.vscode-elixir-ls
      gleam.gleam
      gruntfuggly.todo-tree
      jnoortheen.nix-ide
      mkhl.direnv
      phoenixframework.phoenix
      pkief.material-icon-theme
      tamasfe.even-better-toml
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "ruby-lsp";
        publisher = "Shopify";
        version = "0.6.7";
        sha256 = "sha256-zVhQBpTPGR8vKGQY+MfDmlSR18vfESMOrXhGF/bo9Kc=";
      }
      {
        name = "vscode-rdbg";
        publisher = "KoichiSasada";
        version = "0.2.2";
        sha256 = "sha256-iqUxaMIeqMAyh5EyOiOxraGZZpZUegschMoVjtWz67c=";
      }
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
      "elixirLS.dialyzerEnabled" = false;
      "elixirLS.suggestSpecs" = false;
      "emmet.includeLanguages" = {
        "elixir" = "html";
        "phoenix-heex" = "html";
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
      EDITOR="codium --wait"
    '';
  };
}
