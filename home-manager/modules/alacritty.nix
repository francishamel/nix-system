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
    };
  };
}
