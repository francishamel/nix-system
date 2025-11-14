{ config, ... }:
{
  flake = {
    meta.user = rec {
      gitEmail = "36383308+francishamel@users.noreply.github.com";
      name = "Francis Hamel";
      username = "francishamel";
      githubUsername = username;
    };

    modules = {
      nixos.base = {
        users.users.${config.flake.meta.user.username} = {
          isNormalUser = true;
          initialPassword = "";
          extraGroups = [ "input" ];
        };

        nix.settings.trusted-users = [ config.flake.meta.user.username ];
      };
      darwin.base = {
        users.users.${config.flake.meta.user.username} = {
          name = config.flake.meta.user.username;
          home = "/Users/${config.flake.meta.user.username}";
        };

        system.primaryUser = config.flake.meta.user.username;

        nix.settings.trusted-users = [ config.flake.meta.user.username ];
      };
    };
  };
}
