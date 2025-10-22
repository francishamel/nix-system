{ config, ... }:
{
  flake = {
    meta.user = {
      username = "francishamel";
    };

    modules = {
      nixos.base = {
        users.users.${config.flake.meta.user.username} = {
          isNormalUser = true;
          initialPassword = "";
          extraGroups = [ "input" ];
        };
      };
      darwin.base = {
        users.users.${config.flake.meta.user.username} = {
          name = config.flake.meta.user.username;
          home = "/Users/${config.flake.meta.user.username}";
        };

        system.primaryUser = config.flake.meta.user.username;
      };
    };
  };
}
