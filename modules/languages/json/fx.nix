{ config, lib, ... }:

{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.fx ];

      programs.zsh.initContent = lib.mkOrder config.my.zsh.initOrder.aliases ''
        alias -s json=${lib.getExe pkgs.fx}
      '';
    };
}
