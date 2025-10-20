{ ... }:

{
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    extraOptions = [
      "--group"
      "--group-directories-first"
      "--header"
      "--hyperlink"
    ];
    git = true;
    icons = "auto";
  };
}
