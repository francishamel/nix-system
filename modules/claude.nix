{
  nixpkgs.allowedUnfreePackages = [
    "claude-code"
  ];
  flake = {
    modules = {
      homeManager.base.programs.claude-code.enable = true;
      darwin.base.homebrew.casks = [ "claude" ];
    };
  };
}
