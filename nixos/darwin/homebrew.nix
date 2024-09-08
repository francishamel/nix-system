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
      "google-chrome"
      "obsidian"
      "raycast"
      "spotify"
      "todoist"
      "yubico-yubikey-manager"
    ];
  };
}
