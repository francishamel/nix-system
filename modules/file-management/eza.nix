{
  flake.modules.homeManager.base = {
    programs.eza = {
      enable = true;
      enableZshIntegration = true;
      extraOptions = [
        "--git-repos-no-status"
        "--group"
        "--group-directories-first"
        "--header"
        "--hyperlink"
      ];
      icons = "auto";
    };
  };
}
