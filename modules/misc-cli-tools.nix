{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.cachix
        pkgs.google-cloud-sdk
        pkgs.just
      ];
    };
}
