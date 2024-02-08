{ ... }:

{
  homebrew = {
    onActivation = {
      autoUpdate = false;
      cleanup = "zap";
    };
    enable = true;
    casks = [
      "1password"
      "1password-cli"
      "dash"
      "discord"
      "firefox"
      "google-chrome"
      "obsidian"
      "raycast"
      "slack"
      "spotify"
      "todoist"
    ];
  };
}
