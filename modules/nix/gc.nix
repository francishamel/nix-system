{
  flake.modules =
    let
      gcModule = {
        nix.gc = {
          automatic = true;
          options = "--delete-older-than 30d";
        };
      };
    in
    {

      darwin.base = gcModule;
      nixos.base = gcModule;
      homeManager.base = gcModule;
    };
}
