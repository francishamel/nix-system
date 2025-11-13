{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-darwin.url = "github:lnl7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";

    import-tree.url = "github:vic/import-tree";

    _1password-shell-plugins.url = "github:1Password/shell-plugins";

    try.url = "github:tobi/try";

    wrappers.url = "github:lassulus/wrappers";
  };

  outputs = inputs@{ ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.treefmt-nix.flakeModule
        ./old_modules/flake-module.nix
        ./hosts/flake-module.nix
        (inputs.import-tree ./modules)
      ];

      perSystem = { ... }: {
        treefmt = {
          flakeFormatter = true;
          projectRootFile = "flake.nix";
          programs = {
            deadnix.enable = true;
            nixpkgs-fmt.enable = true;
            prettier.enable = true;
            stylua.enable = true;
            taplo.enable = true;
          };
          settings.global.excludes = [
            ".envrc"
            "flake.lock"
            "justfile"
            "**/.gitkeep"
          ];
        };
      };
    };
}
