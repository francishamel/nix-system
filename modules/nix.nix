{ ... }:

{
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    gc = {
      automatic = true;
      interval = {
        Weekday = 0;
      };
      options = "--delete-older-than 30d";
    };

    registry.francishamel = {
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
  };
}
