{
  nixpkgs.allowedUnfreePackages = [
    "graphite-cli"
  ];

  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.graphite-cli ];
    };
}
