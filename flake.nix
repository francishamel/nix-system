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
      systems = [ "x86_64-darwin" "x86_64-linux" ];
      imports = [
        inputs.treefmt-nix.flakeModule
        inputs.nixos-flake.flakeModule
        ./home
      ];

      flake = {
        # Configurations for macOS machines
        darwinConfigurations = {
          "MacBook-Pro-Intel" = self.nixos-flake.lib.mkIntelMacosSystem {
            imports = [
              ./systems/darwin.nix
              self.darwinModules.home-manager
              {
                home-manager.users.francis = { ... }: {
                  imports = [
                    self.homeModules.common-darwin
                  ];
                };
              }
            ];
          };
        };
      };

      perSystem = { self', pkgs, config, ... }: {
        packages.default = self'.packages.activate; # Enable running nix run .# to switch derivation

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            nil
            nixpkgs-fmt
            config.treefmt.build.wrapper
          ];
        };

        treefmt = {
          flakeFormatter = true;
          projectRootFile = "flake.nix";
          programs = {
            deadnix.enable = true;
            nixpkgs-fmt.enable = true;
            prettier.enable = true;
          };
        };
      };
    };
}
