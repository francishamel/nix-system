{
  flake.modules.homeManager.gui =
    { pkgs, ... }:
    {
      programs.ghostty = {
        enable = true;
        package = pkgs.ghostty-bin;
        clearDefaultKeybinds = true;
        settings = {
          # TODO: styling concern
          theme = "Nord";
          font-family = "FiraCode Nerd Font";
          font-size = 12;

          auto-update = "off";
          maximize = true;

          macos-option-as-alt = true;

          keybind = [
            "super+t=new_tab"

            "super+shift+h=previous_tab"
            "super+shift+l=next_tab"

            "super+d=new_split:down"
            "super+r=new_split:right"

            "super+bracket_left=goto_split:previous"
            "super+bracket_right=goto_split:next"
            "super+h=goto_split:left"
            "super+l=goto_split:right"
            "super+j=goto_split:down"
            "super+k=goto_split:up"

            "super+q=quit"
            "super+w=close_surface"

            "super+c=copy_to_clipboard"
            "super+v=paste_from_clipboard"

            "alt+arrow_left=esc:b"
            "alt+arrow_right=esc:f"
            "super+arrow_left=text:\\x01"
            "super+arrow_right=text:\\x05"

            "super+backspace=text:\\x15"
          ];
        };
        enableZshIntegration = true;
      };
    };
}
