{ ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        dynamic_title = false;
        startup_mode = "Maximized";
        title = "Alacritty";
      };
    };
  };
}
