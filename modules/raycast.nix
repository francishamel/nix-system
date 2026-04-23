{
  flake.modules = {
    homeManager.darwin =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.tesseract ];
      };

    darwin.base.homebrew.casks = [
      "betterdisplay"
      "raycast"
    ];
  };
}
