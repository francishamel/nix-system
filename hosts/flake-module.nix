{ self, inputs, ... }:

{
  flake = {
    darwinConfigurations = {
      "talimachine" = inputs.nix-darwin.lib.darwinSystem {
        modules = [
          self.nixosModules.common
          self.nixosModules.darwin
          inputs.home-manager.darwinModules.home-manager
          {
            nixpkgs.hostPlatform = "aarch64-darwin";

            networking.hostName = "talimachine";

            # These 2 lines are needed to ensure we reuse the nixpkgs config
            # so that we allow unfree packages
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # TODO: parameterize this
            home-manager.users.francis = {
              imports = [
                self.homeModules.common
                self.homeModules.darwin-aarch64
              ];
            };
          }
        ];
      };
    };
    nixosConfigurations = {
      "t420" = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          ./t420
          self.nixosModules.common
          inputs.home-manager.nixosModules.home-manager
          inputs.disko.nixosModules.default
          {
            nixpkgs.hostPlatform = "x86_64-linux";

            networking.hostName = "t420";

            # These 2 lines are needed to ensure we reuse the nixpkgs config
            # so that we allow unfree packages
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # TODO: parameterize this
            home-manager.users.francis = {
              imports = [
                self.homeModules.common
                self.homeModules.x86_64-linux
              ];
            };
          }
        ];
      };
    };
  };
}
