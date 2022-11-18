{ ... }:

{
  programs.git = {
    aliases = { fp = "fetch --prune"; };
    enable = true;
    extraConfig = {
      core.editor = "code --wait";
      init.defaultBranch = "main";
      merge.conflictstyle = "diff3";
      pull.rebase = true;
      rebase = {
        autoStash = true;
        autosquash = true;
      };
    };
    userEmail = "francishamel96@gmail.com";
    userName = "Francis Hamel";
  };
}
