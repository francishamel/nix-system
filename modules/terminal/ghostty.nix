{
  flake.modules.homeManager.gui =
    { pkgs, ... }:
    {
      programs.ghostty = {
        enable = true;
        package = pkgs.ghostty-bin;
        clearDefaultKeybinds = true;
        settings = {
          theme = "Nord";
          font-family = "FiraCode Nerd Font";
          font-size = 14;
          auto-update = "off";
          maximize = true;

          keybind = [
            "super+t=new_tab"
            "super+shift+h=previous_tab"
            "super+shift+l=next_tab"

            "super+d=new_split:down"
            "super+r=new_split:right"
            "super+h=goto_split:previous"
            "super+l=goto_split:next"

            "super+q=quit"
            "super+w=close_surface"

            "super+c=copy_to_clipboard"
            "super+v=paste_from_clipboard"
          ];
        };
        enableZshIntegration = true;
      };
    };
}
