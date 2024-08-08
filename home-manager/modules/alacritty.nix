{ ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
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
