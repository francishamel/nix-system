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

  outputs = { darwin, flake-utils, home-manager, nixpkgs, self, ... }:
    let
      inherit (flake-utils.lib) defaultSystems eachSystemMap system;
      inherit (nixpkgs.lib) filterAttrs mapAttrs';
    in
    {
      legacyPackages = eachSystemMap defaultSystems (system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
      );

      darwinConfigurations."MacBook-Pro-Intel" = darwin.lib.darwinSystem {
        system = system.x86_64-darwin;
        pkgs = self.legacyPackages.x86_64-darwin;
        modules = import ./modules/darwin/list.nix ++ [
          ./configs/darwin/macbook-pro.nix
          (home-manager.darwinModules.home-manager)
          {
            _module.args = { utilities = import ./utilities { inherit filterAttrs mapAttrs'; }; };
          }
        ];
      };

      homeConfigurations.spin = home-manager.lib.homeManagerConfiguration {
        pkgs = self.legacyPackages.x86_64-linux;
        modules = import ./modules/home-manager/list.nix ++ [ ./configs/home-manager/spin.nix ];
      };

      devShells = eachSystemMap defaultSystems (system:
        let
          pkgs = self.legacyPackages.${system};
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
