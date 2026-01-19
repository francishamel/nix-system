{ lib, ... }:

{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.fx ];

      programs.zsh.initExtra = ''
        alias -s json=${lib.getExe pkgs.fx}
      '';
    };
}
