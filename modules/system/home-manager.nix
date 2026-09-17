{ inputs, config, ... }:

{
  flake.modules.darwin.base = {
    imports = [ inputs.home-manager.darwinModules.home-manager ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";

      users.${config.flake.meta.user.username}.imports = [
        config.flake.modules.homeManager.base
        config.flake.modules.homeManager.darwin
      ];
    };
  };

  flake.modules.homeManager.base.xdg.enable = true;
}
