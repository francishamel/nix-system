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

      # Temporary needed software
      # "balenaetcher" # For burning img/iso on sd cards/usb drive
      # "microsoft-teams"
      # "zoom"
    ];
  };
}
