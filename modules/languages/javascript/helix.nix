{ lib, ... }:
{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    let
      prettierFormatter = {
        command = lib.getExe pkgs.prettier;
        args = [
          "--parser"
          "typescript"
        ];
      };
    in
    {
      programs.helix = {
        extraPackages = [
          pkgs.prettier
          pkgs.typescript-language-server
        ];
        languages.language = [
          {
            name = "javascript";
            auto-format = true;
            formatter = prettierFormatter;
          }
          {
            name = "typescript";
            auto-format = true;
            formatter = prettierFormatter;
          }
          {
            name = "tsx";
            auto-format = true;
            formatter = prettierFormatter;
          }
        ];
      };
    };
}
