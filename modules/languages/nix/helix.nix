{ lib, ... }:
{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      programs.helix = {
        extraPackages = [
          pkgs.nil
          pkgs.nixd
        ];
        languages = {
          language-server.nixd.command = lib.getExe pkgs.nixd;
          language = [
            {
              name = "nix";
              auto-format = true;
              formatter.command = lib.getExe pkgs.nixfmt;
              language-servers = [
                "nixd"
                "nil"
              ];
            }
          ];
        };
      };
    };
}
