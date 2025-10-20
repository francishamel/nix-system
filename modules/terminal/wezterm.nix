{
  flake.modules.homeManager.gui = {
    programs.wezterm = {
      enable = false;
      enableZshIntegration = true;
      extraConfig = builtins.readFile ./wezterm/config.lua;
    };
  };
}
