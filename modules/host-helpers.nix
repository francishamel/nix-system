{ inputs, self, ... }:

{
  flake.lib = {
    # Helper function to create a nix-darwin host configuration (Apple Silicon)
    mkDarwinHost =
      { hostname }:
      inputs.nix-darwin.lib.darwinSystem {
        modules = [
          self.modules.darwin.base
          {
            nixpkgs.hostPlatform = "aarch64-darwin";
            networking.hostName = hostname;
          }
        ];
      };
  };
}
