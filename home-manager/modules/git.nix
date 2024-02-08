{ ... }:

{
  programs.git = {
    userName = "Francis Hamel";
    userEmail = "36383308+francishamel@users.noreply.github.com";
    aliases = {
      fp = "fetch --prune";
      pfwl = "push --force-with-lease";
    };
    enable = true;
    extraConfig = {
      core.editor = "codium --wait";
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
