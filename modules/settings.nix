{ lib, config, ... }:
let
  # A nix.conf value: a scalar, or a list of them. Lists concatenate when two
  # modules set the same key, so no key needs declaring before a module uses it.
  atom = lib.types.oneOf [
    lib.types.bool
    lib.types.int
    lib.types.str
  ];
in
{
  options.nix.settings = lib.mkOption {
    type = lib.types.attrsOf (lib.types.either atom (lib.types.listOf atom));
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
      homeManager.base.nix.settings = (config.nix).settings;
    };
  };
}
