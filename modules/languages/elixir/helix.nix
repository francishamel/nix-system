{ lib, ... }:
{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      programs.helix = {
        extraPackages = [ pkgs.elixir-ls ];
        languages.language = [
          {
            name = "elixir";
            auto-format = true;
            formatter = {
              command = lib.getExe' pkgs.elixir "mix";
              args = [ "format" ];
            };
          }
        ];
      };
    };
}
