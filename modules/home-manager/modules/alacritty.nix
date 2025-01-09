{ ... }:

{
  programs.alacritty = {
    enable = false;
    settings = {
      # Nord theme taken from: https://github.com/alacritty/alacritty-theme/blob/95a7d695605863ede5b7430eb80d9e80f5f504bc/themes/nord.toml
      # TODO: use fetchUrl 
      colors = {
        primary = {
          background = "#2E3440";
          foreground = "#D8DEE9";
        };
        normal = {
          black = "#3B4252";
          red = "#BF616A";
          green = "#A3BE8C";
          yellow = "#EBCB8B";
          blue = "#81A1C1";
          magenta = "#B48EAD";
          cyan = "#88C0D0";
          white = "#E5E9F0";
        };
        bright = {
          black = "#4C566A";
          red = "#BF616A";
          green = "#A3BE8C";
          yellow = "#EBCB8B";
          blue = "#81A1C1";
          magenta = "#B48EAD";
          cyan = "#8FBCBB";
          white = "#ECEFF4";
        };
      };
      font.normal = {
        family = "FiraCode Nerd Font";
        style = "Regular";
      };
      window = {
        dynamic_title = false;
        option_as_alt = "Both";
        startup_mode = "Maximized";
        title = "Alacritty";
      };

      # See https://portal.cs.umbc.edu/help/theory/ascii.txt
      keyboard.bindings = [
        { key = "Backspace"; mods = "Command"; chars = "\\u0015"; }
        { key = "Backspace"; mods = "Alt"; chars = "\\u0017"; }
        { key = "Left"; mods = "Command"; chars = "\\u0001"; }
        { key = "Right"; mods = "Command"; chars = "\\u0005"; }
        { key = "Left"; mods = "Alt"; chars = "\\u001b\\u0062"; }
        { key = "Right"; mods = "Alt"; chars = "\\u001b\\u0066"; }
      ];
    };
  };
}
