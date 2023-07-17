{ inputs, ... }:

{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem = { pkgs, config, ... }: {
    # packages.default = self'.packages.activate; # Enable running nix run .# to switch derivation

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
}
