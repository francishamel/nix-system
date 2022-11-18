{ ... }:

{
  # Cleanup nix weekly on Sundays
  nix.gc = {
    automatic = true;
    interval = {
      Weekday = 0;
    };
    options = "--delete-older-than 30d";
  };

  # Enable nix flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  nix.registry.francishamel = {
    from = {
      id = "francishamel";
      type = "indirect";
    };
    to = {
      owner = "francishamel";
      repo = "nix-templates";
      type = "github";
      ref = "main";
    };
  };
}
