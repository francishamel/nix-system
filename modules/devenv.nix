{ config, lib, ... }:
{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.devenv ];

      programs.zsh = {
        initContent = lib.mkOrder config.my.zsh.initOrder.interactive ''
          eval "$(${lib.getExe pkgs.devenv} hook zsh)"
        '';

        shellAliases."dt" = "${lib.getExe pkgs.devenv} tasks run";
      };
    };
}
