{ lib, ... }:
{
  flake.modules.homeManager.base =
    { config, ... }:
    {
      programs = {
        devenv.enable = true;

        zsh.shellAliases."dt" = "${lib.getExe config.programs.devenv.package} tasks run";
      };
    };
}
