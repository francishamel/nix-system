{
  flake = {
    modules.homeManager.darwin =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.tesseract ];
      };
    modules.darwin.base.homebrew.casks = [ "raycast" ];
  };
}
