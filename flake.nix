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

    nixos-flake.url = "github:srid/nixos-flake";
  };

  outputs = inputs@{ self, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "aarch64-darwin" "x86_64-linux" ];
      imports = [
        inputs.nixos-flake.flakeModule
        inputs.treefmt-nix.flakeModule
        ./home-manager/flake-module.nix
        ./nixos/flake-module.nix
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

      flake = {
        darwinConfigurations."talimachine" = self.nixos-flake.lib.mkMacosSystem {
          nixpkgs.hostPlatform = "aarch64-darwin";
          imports = [
            self.nixosModules.common
            self.nixosModules.darwin
            self.darwinModules_.home-manager
            {
              networking.hostName = "talimachine";
              # TODO: parameterize this
              home-manager.users.francis = {
                imports = [
                  self.homeModules.common
                  self.homeModules.darwin-aarch64
                ];
              };
            }
          ];
        };
      };
    };
}
