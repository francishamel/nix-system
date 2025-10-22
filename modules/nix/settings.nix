{ lib, config, ... }:
{
  options.nix.settings = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.anything;
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
