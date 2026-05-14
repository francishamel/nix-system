{ lib, ... }:
{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.devenv ];

      programs.zsh.initContent = ''
        eval "$(${lib.getExe pkgs.devenv} hook zsh)"
      '';
    };
}
