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
      "discord"
      "docker"
      "firefox"
      "obsidian"
      "raycast"
      "slack"
      "spotify"
      "todoist"
    ];
  };
}
