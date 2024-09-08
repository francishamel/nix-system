{ ... }:

{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      default_layout = "compact";
      on_force_close = "quit";
      theme = "nord";
      ui.pane_frames.rounded_corners = true;
    };
  };

  xdg.configFile."zellij/layouts" = {
    recursive = true;
    source = ./zellij/layouts;
  };
}
