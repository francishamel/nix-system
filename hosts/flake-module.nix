{ self, inputs, ... }:

{
  flake = {
    darwinConfigurations = {
      "talimachine" = self.nixos-flake.lib.mkMacosSystem {
        nixpkgs.hostPlatform = "aarch64-darwin";
        imports = [
          self.nixosModules.common
          self.nixosModules.darwin
          inputs.home-manager.darwinModules.home-manager
          {
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
  };
}
