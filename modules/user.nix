{ config, lib, ... }:
let
  user = config.flake.meta.user;
in
{
  options.flake.meta.user = lib.mkOption {
    description = "The single human this configuration is built for.";
    type = lib.types.submodule {
      options = {
        username = lib.mkOption {
          type = lib.types.str;
          description = "POSIX account name. Also the home-manager user and the macOS primary user.";
        };

        name = lib.mkOption {
          type = lib.types.str;
          description = "Full name, as it appears in commit authorship.";
        };

        gitEmail = lib.mkOption {
          type = lib.types.str;
          description = "Author email for git and jujutsu commits, and the identity in the SSH allowed-signers file.";
        };

        githubUsername = lib.mkOption {
          type = lib.types.str;
          description = "GitHub handle, used by the gh CLI.";
        };
      };
    };
  };

  config.flake = {
    meta.user = {
      gitEmail = "36383308+francishamel@users.noreply.github.com";
      name = "Francis Hamel";
      username = "francis";
      githubUsername = "francishamel";
    };

    modules.darwin.base = {
      users.users.${user.username} = {
        name = user.username;
        home = "/Users/${user.username}";
      };

      system.primaryUser = user.username;

      nix.settings.trusted-users = [ user.username ];
    };
  };
}
