{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      programs.helix.extraPackages = [ pkgs.yaml-yaml-language-server ];
    };
}
