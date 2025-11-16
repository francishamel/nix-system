{ lib, ... }:
{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      programs.helix = {
        extraPackages = [ pkgs.tinymist ];
        languages.language = [
          {
            name = "typst";
            auto-format = true;
            formatter.command = lib.getExe pkgs.typstyle;
          }
        ];
      };
    };
}
