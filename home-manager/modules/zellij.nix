{ ... }:

{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      on_force_close = "quit";
      pane_frames = false;
    };
  };
}