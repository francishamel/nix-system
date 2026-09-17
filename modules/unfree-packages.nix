{ lib, config, ... }:
let
  allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) config.nixpkgs.allowedUnfreePackages;
in
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
    # darwin only. home-manager.useGlobalPkgs (modules/home-manager.nix) makes
    # home-manager reuse these pkgs, so the predicate covers it too. Setting
    # nixpkgs.config on homeManager.base instead only warns and does nothing.
    modules.darwin.base.nixpkgs.config = { inherit allowUnfreePredicate; };

    meta.nixpkgs.allowedUnfreePackages = config.nixpkgs.allowedUnfreePackages;
  };
}
