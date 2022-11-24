{
  description = "nix system configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { darwin, flake-utils, home-manager, nixpkgs, ... }@inputs: rec {
    inherit (flake-utils.lib) defaultSystems eachSystemMap system;

    legacyPackages = eachSystemMap defaultSystems (system:
      import inputs.nixpkgs {
        inherit system;
        # NOTE: Using `nixpkgs.config` in your NixOS config won't work
        # Instead, you should set nixpkgs configs here
        # (https://nixos.org/manual/nixpkgs/stable/#idm140737322551056)

        config.allowUnfree = true;
      }
    );

    darwinConfigurations."MacBook-Pro-Intel" = darwin.lib.darwinSystem {
      system = system.x86_64-darwin;
      pkgs = legacyPackages.x86_64-darwin;
      specialArgs = { inherit inputs; }; # Pass flake inputs to our config
      modules = import ./modules/darwin/list.nix ++ [
        ./old-modules/darwin
        ./old-modules/nix.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.extraSpecialArgs = { inherit inputs; }; # Pass flake inputs to our config
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.francis = import ./configs/home-manager;
        }
      ];
    };

    devShells = eachSystemMap
      defaultSystems
      (system:
        let
          pkgs = legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              nil
              nixpkgs-fmt
              treefmt
            ];
          };
        }
      );
  };
}
