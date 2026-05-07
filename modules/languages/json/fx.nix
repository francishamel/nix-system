{ lib, ... }:

{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.fx ];

      programs.zsh.initContent = ''
        alias -s json=${lib.getExe pkgs.fx}
      '';
    };
}
