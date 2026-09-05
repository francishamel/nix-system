{ lib, config, ... }:
{
  options.nixpkgs.allowedUnfreePackages = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
  };

  config.flake.modules.darwin.base.nixpkgs.config.allowUnfreePredicate =
    pkg: builtins.elem (lib.getName pkg) config.nixpkgs.allowedUnfreePackages;

  config.flake.meta.nixpkgs.allowedUnfreePackages = config.nixpkgs.allowedUnfreePackages;
}
