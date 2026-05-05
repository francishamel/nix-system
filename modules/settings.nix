{ lib, config, ... }:

{
  options.nix.settings = lib.mkOption {
    type = lib.types.submodule {
      freeformType = lib.types.attrsOf lib.types.anything;
      options = {
        extra-substituters = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
        };
        extra-trusted-public-keys = lib.mkOption {
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
    };
    flake.modules = {
      darwin.base.nix.settings = (config.nix).settings;
      nixos.base.nix.settings = (config.nix).settings;
      homeManager.base.nix.settings = (config.nix).settings;
    };
  };
}
