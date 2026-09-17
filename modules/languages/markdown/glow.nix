{ config, lib, ... }:
{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.glow ];

      programs.zsh.initContent = lib.mkOrder config.my.zsh.initOrder.aliases ''
        alias -s md=glow
      '';
    };
}
