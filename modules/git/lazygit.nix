{ lib, ... }:
{
  flake.modules.homeManager.base =
    { config, ... }:
    {
      programs = {
        lazygit = {
          enable = true;
          settings = {
            git = {
              overrideGpg = true;
              skipHookPrefix = "fixup!";
            };
            gui.nerdFontsVersion = "3";
          };
        };

        zsh.shellAliases.lg = lib.getExe config.programs.lazygit.package;
      };
    };
}
