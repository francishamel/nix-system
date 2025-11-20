{ inputs, ... }:
{
  imports = [
    inputs.treefmt-nix.flakeModule
  ];

  flake.perSystem = {
    treefmt = {
      flakeFormatter = true;
      programs = {
        deadnix.enable = true;
        nixfmt.enable = true;
        prettier.enable = true;
        stylua.enable = true;
        taplo.enable = true;
      };
      settings.global.excludes = [
        ".envrc"
        "flake.lock"
        "justfile"
      ];
    };
  };
}
