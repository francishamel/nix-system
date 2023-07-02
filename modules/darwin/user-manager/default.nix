{ config, lib, pkgs, utilities, ... }:
let
  inherit (lib) mapAttrs mkOption nameValuePair types mapAttrsToList;
  inherit (utilities) mapFilterAttrs;

  cfg = config.modules.user-manager;

  userOpts = { name, ... }: {
    options = {
      home = mkOption {
        default = null;
        type = types.nullOr types.path;
        description = ''
          The path to the home-manager configuration to build for this user.
        '';
      };
      uid = mkOption {
        type = types.int;
      };
    };
  };
in
{
  options = {
    modules.user-manager.users = mkOption {
      default = { };
      type = types.attrsOf (types.submodule userOpts);
      description = ''
        Users to be managed by this module. Intuitively this option enables
        extra user-specific options compared to 'users.users'. For users
        managed by user-manager, their definitions for 'users.users' and
        'home-manager.users' are not intended to be written manually but derived
        from this definition. As a result, some of those modules' options must
        be mirrored here, however the benefits outweight the detriments.
      '';
    };
  };

  config = {
    # Derive a nix-darwin user definition for every user-manager user definition.
    users.users =
      mapAttrs
        (username: { uid, ... }: {
          inherit uid;
          createHome = true;
          home = "/Users/${username}";
          shell = pkgs.zsh;
          isHidden = false;
        })
        cfg.users;

    users.knownUsers =
      mapAttrsToList
        (username: { ... }: username)
        cfg.users;

    # Derive a home-manager user definition for every user manager user with
    # a `home` attribute defined.
    home-manager.users =
      mapFilterAttrs
        (username: { home, ... }: nameValuePair username (import home))
        (_: { home, ... }: home != null)
        cfg.users;
  };
}
