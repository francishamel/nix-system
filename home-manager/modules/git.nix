{ config, pkgs, ... }:

{
  programs.git = {
    userName = "Francis Hamel";
    userEmail = "36383308+francishamel@users.noreply.github.com";
    aliases = {
      ca = "commit --amend --no-edit";
      cae = "commit --amend";
      cf = "commit --fixup";
      fp = "fetch --prune";
      pfwl = "push --force-with-lease";
      ri = "rebase --interactive";
    };
    enable = true;
    extraConfig = {
      core.editor = "${pkgs.vscode}/bin/code --wait";
      init.defaultBranch = "main";
      merge.conflictstyle = "diff3";
      pull.rebase = true;
      rebase = {
        autoStash = true;
        autosquash = true;
      };
      rerere.enabled = true;
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = false;
    settings = {
      aliases = {
        "prc" = "pr create --web --assignee @me";
        "prv" = "pr view --web";
        "rc" = "repo clone $1 ${config.home.homeDirectory}/src/$1";
      };
      editor = "${pkgs.vscode}/bin/code --wait";
      git_protocol = "ssh";
    };
  };
}
