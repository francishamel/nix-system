{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      programs.helix.extraPackages = [ pkgs.lua-language-server ];
    };
}
