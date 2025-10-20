{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.cachix
        pkgs.devenv
        pkgs.flyctl
        pkgs.glow
        pkgs.google-cloud-sdk
        pkgs.just
      ];
    };
}


