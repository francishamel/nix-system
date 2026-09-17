{ lib, ... }:
{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      programs.helix = {
        extraPackages = [ pkgs.prettier ];
        languages.language = [
          {
            name = "json";
            auto-format = true;
            formatter = {
              command = lib.getExe pkgs.prettier;
              args = [
                "--parser"
                "json"
              ];
            };
          }
        ];
      };
    };
}
