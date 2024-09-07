{ ... }:

{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      on_force_close = "quit";
      ui.pane_frames.rounded_corners = true;
    };
  };
}
