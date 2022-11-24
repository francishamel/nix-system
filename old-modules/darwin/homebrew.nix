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
      # Disabled 1password-cli to manually install the beta package which is not on homebrew
      # "1password-cli"
      "discord"
      "firefox"
      "obsidian"
      "raycast"
      "slack"
      "spotify"
      "todoist"
      "zoom"
    ];
  };
}
