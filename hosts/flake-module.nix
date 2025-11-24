{
  config,
  self,
  inputs,
  ...
}:

{
  flake = {
    darwinConfigurations = {
      "clicknpark-macbook" = inputs.nix-darwin.lib.darwinSystem {
        modules = [
          self.modules.darwin.base
          inputs.home-manager.darwinModules.home-manager
          {
            nixpkgs.hostPlatform = "aarch64-darwin";

            networking.hostName = "clicknpark-macbook";

            # These 2 lines are needed to ensure we reuse the nixpkgs config
            # so that we allow unfree packages
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.backupFileExtension = "backup";

            home-manager.users.${config.flake.meta.user.username} = {
              imports = [
                self.modules.homeManager.base
                self.modules.homeManager.darwin
                self.modules.homeManager.darwinAarch64
                self.modules.homeManager.gui
              ];
            };
          }
        ];
      };
    };
  };
}
