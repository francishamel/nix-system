{ lib, config, ... }:

{
  options.nix.settings = lib.mkOption {
    type = lib.types.submodule {
      freeformType = lib.types.attrsOf lib.types.anything;
      options = {
        substituters = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
        };
        trusted-public-keys = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
        };

      };
    };
    default = { };
  };

  config = {
    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];
      substituters = [ "https://cache.nixos.org" ];
      trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
    };
    flake.modules = {
      darwin.base.nix.settings = (config.nix).settings;
      nixos.base.nix.settings = (config.nix).settings;
      homeManager.base.nix.settings = (config.nix).settings;
    };
  };
}
