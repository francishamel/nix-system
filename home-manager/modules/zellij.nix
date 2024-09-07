{ ... }:

{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      default_layout = "compact";
      on_force_close = "quit";
      ui.pane_frames.rounded_corners = true;
    };
  };
}
