{
  inputs,
  self,
  config,
  ...
}:

{
  flake.lib = {
    # Helper function to create an Apple Silicon (aarch64) nix-darwin host configuration
    mkDarwinHostAarch64 =
      { hostname }:
      inputs.nix-darwin.lib.darwinSystem {
        modules = [
          self.modules.darwin.base
          inputs.home-manager.darwinModules.home-manager
          {
            nixpkgs.hostPlatform = "aarch64-darwin";
            networking.hostName = hostname;

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";

            home-manager.users.${config.flake.meta.user.username}.imports = [
              self.modules.homeManager.base
              self.modules.homeManager.darwin
              self.modules.homeManager.darwinAarch64
              self.modules.homeManager.gui
            ];
          }
        ];
      };

    # Helper function to create an Intel (x86_64) nix-darwin host configuration
    mkDarwinHostX86_64 =
      { hostname }:
      inputs.nix-darwin.lib.darwinSystem {
        modules = [
          self.modules.darwin.base
          inputs.home-manager.darwinModules.home-manager
          {
            nixpkgs.hostPlatform = "x86_64-darwin";
            networking.hostName = hostname;

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";

            home-manager.users.${config.flake.meta.user.username}.imports = [
              self.modules.homeManager.base
              self.modules.homeManager.darwin
              self.modules.homeManager.gui
            ];
          }
        ];
      };
  };
}
