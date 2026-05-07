{ lib, ... }:
{
  nix.settings = {
    extra-substituters = [ "https://devenv.cachix.org" ];
    extra-trusted-public-keys = [ "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=" ];
  };

  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.devenv ];

      programs.zsh.initContent = ''
        eval "$(${lib.getExe pkgs.devenv} hook zsh)"
      '';
    };
}
