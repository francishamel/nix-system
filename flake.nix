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

  outputs = { darwin, flake-utils, home-manager, nixpkgs, ... }: rec {
    inherit (flake-utils.lib) defaultSystems eachSystemMap system;

    utilities = import ./utilities { inherit (nixpkgs) lib; };

    legacyPackages = eachSystemMap defaultSystems (system:
      import nixpkgs {
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
      modules = import ./modules/darwin/list.nix ++ [
        ./configs/darwin/macbook-pro.nix
        (home-manager.darwinModules.home-manager)
        {
          _module.args = { inherit utilities; };
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
