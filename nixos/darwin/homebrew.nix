{ ... }:

let
  # Change to true when you want to upgrade homebrew packages
  upgrade = false;
in
{
  homebrew = {
    onActivation = {
      autoUpdate = upgrade;
      cleanup = "zap";
      upgrade = upgrade;
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
