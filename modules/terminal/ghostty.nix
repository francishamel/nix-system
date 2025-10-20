{
  flake.modules.homeManager.gui =
    { pkgs, ... }:
    {
      programs.ghostty = {
        enable = true;
        package = pkgs.ghostty-bin;
        settings = {
          theme = "Nord";
          font-family = "FiraCode Nerd Font";
          font-size = 14;
          auto-update = "off";
          maximize = true;
        };
        enableZshIntegration = true;
      };
    };
}
