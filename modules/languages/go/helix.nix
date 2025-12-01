{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      programs.helix.extraPackages = [
        pkgs.gopls
        pkgs.golangci-lint
      ];
    };
}
