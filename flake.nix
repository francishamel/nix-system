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
  };

  outputs = inputs@{ ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "aarch64-darwin" "x86_64-linux" ];
      imports = [
        inputs.treefmt-nix.flakeModule
        ./home-manager/flake-module.nix
        ./modules/flake-module.nix
        ./hosts/flake-module.nix
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
            ".gitignore"
            "flake.lock"
            "justfile"
            "**/.gitkeep"
          ];
        };
      };
    };
}
