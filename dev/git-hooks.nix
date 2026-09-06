{ inputs, ... }:
{
  imports = [
    inputs.git-hooks.flakeModule
  ];

  perSystem =
    { config, ... }:
    {
      pre-commit.settings.hooks.treefmt = {
        enable = true;
        packageOverrides.treefmt = config.treefmt.build.wrapper;
      };

      devShells.default = config.pre-commit.devShell;
    };
}
