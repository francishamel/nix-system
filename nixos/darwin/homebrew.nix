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
      "arc"
      "dash"
      "datagrip"
      "discord"
      "google-chrome"
      "obsidian"
      "raycast"
      "slack"
      "spotify"
      "todoist"
      "yubico-yubikey-manager"
    ];
  };
}
