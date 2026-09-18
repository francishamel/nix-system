{ lib, ... }:
{
  perSystem =
    { config, pkgs, ... }:
    {
      options.my.devShell = {
        packages = lib.mkOption {
          type = lib.types.listOf lib.types.package;
          default = [ ];
          description = "Packages dev modules add to the default shell.";
        };

        inputsFrom = lib.mkOption {
          type = lib.types.listOf lib.types.package;
          default = [ ];
          description = "Shells dev modules merge into the default shell.";
        };
      };

      config.devShells.default = pkgs.mkShell {
        inherit (config.my.devShell) packages inputsFrom;
      };
    };
}
