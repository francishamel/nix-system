{ inputs, ... }:
{
  nix.settings = {
    substituters = [ "https://devenv.cachix.org" ];
    trusted-public-keys = [ "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=" ];
  };

  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = [ inputs.devenv.packages.${pkgs.stdenv.hostPlatform.system}.devenv ];
    };
}
