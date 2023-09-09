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

    stylix.url = "github:danth/stylix";
  };

  outputs = inputs@{ self, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-darwin" "x86_64-linux" ];
      imports = [
        inputs.nixos-flake.flakeModule
        ./devshell/flake-module.nix
        ./home-manager/flake-module.nix
      ];

      flake = {
        # Configurations for macOS machines
        darwinConfigurations = {
          "MacBook-Pro-Intel" = self.nixos-flake.lib.mkMacosSystem {
            nixpkgs.hostPlatform = "x86_64-darwin";
            imports = [
              ./systems/macbook-intel-pro
              self.darwinModules.home-manager
              {
                home-manager.users.francis = { ... }: {
                  imports = [
                    self.homeModules.common
                    self.homeModules.darwin
                  ];
                  home.stateVersion = "22.11";
                };
              }
            ];
          };
        };
      };
    };
}
