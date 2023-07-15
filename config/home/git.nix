{ ... }:

{
  programs.git = {
    userName = "Francis Hamel";
    userEmail = "36383308+francishamel@users.noreply.github.com";
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
  };
}
