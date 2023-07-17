{ inputs, ... }:

{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem = { pkgs, config, ... }: {
    devShells.default = pkgs.mkShell {
      nativeBuildInputs = with pkgs; [
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
