{ lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  options.home-manager.users = mkOption {
    type = types.attrsOf (types.submoduleWith {
      modules = (import ../../../modules/home-manager/list.nix);
    });
  };

  config = {
    home-manager.useUserPackages = true;
    home-manager.useGlobalPkgs = true;
  };
}
