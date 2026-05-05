{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      programs.helix.extraPackages = [ pkgs.gleam ];
    };
}
