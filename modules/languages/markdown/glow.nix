{ lib, ... }:

{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.glow ];

      programs.zsh = {
        shellAliases = {
          "glow" = "${lib.getExe pkgs.glow} --tui";
        };
        initExtra = ''
          alias -s md=glow
        '';
      };
    };
}
