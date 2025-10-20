{ self, inputs, ... }:

{
  flake = {
    darwinConfigurations = {
      "clicknpark-macbook" = inputs.nix-darwin.lib.darwinSystem {
        modules = [
          self.nixosModules.common
          self.nixosModules.darwin
          inputs.home-manager.darwinModules.home-manager
          {
            nixpkgs.hostPlatform = "aarch64-darwin";

            networking.hostName = "clicknpark-macbook";

            # These 2 lines are needed to ensure we reuse the nixpkgs config
            # so that we allow unfree packages
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.backupFileExtension = "backup";

            # TODO: parameterize this
            home-manager.users.francishamel = {
              imports = [
                self.homeModules.common
                self.homeModules.aarch64-darwin
              ];
            };
          }
        ];
      };
    };
  };
}
