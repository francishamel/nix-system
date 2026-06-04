{
  inputs,
  self,
  config,
  ...
}:

{
  flake.lib = {
    # Helper function to create a nix-darwin host configuration (Apple Silicon)
    mkDarwinHost =
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
              self.modules.homeManager.gui
            ];
          }
        ];
      };
  };
}
