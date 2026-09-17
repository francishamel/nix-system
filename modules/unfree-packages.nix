{ lib, config, ... }:
{
  options = {
    nixpkgs.allowedUnfreePackages = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "Unfree package names to allow. Every module adds its own; this file aggregates them.";
    };

    flake.meta.nixpkgs.allowedUnfreePackages = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
      description = "The aggregated allow list, re-exported so `nix eval .#meta` can report it. No module reads it back.";
    };
  };

  config.flake = {
    modules.darwin.base.nixpkgs.config.allowUnfreePredicate =
      pkg: builtins.elem (lib.getName pkg) config.nixpkgs.allowedUnfreePackages;

    meta.nixpkgs.allowedUnfreePackages = config.nixpkgs.allowedUnfreePackages;
  };
}
