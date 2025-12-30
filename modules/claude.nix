{
  nixpkgs.allowedUnfreePackages = [
    "claude-code"
  ];
  flake.modules.homeManager.base =
    { ... }:
    {
      programs.claude-code = {
        enable = true;
      };
    };
  flake.modules.darwin.base.homebrew.casks = [ "claude" ];
}
