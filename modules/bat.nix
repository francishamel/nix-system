{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      programs.bat = {
        enable = true;
        config.theme = "Nord";
        syntaxes.gleam = {
          src = pkgs.fetchFromGitHub {
            owner = "digitalcora";
            repo = "sublime-text-gleam";
            rev = "d2662e0fa8120ee21d0793194634fb9d31be9c6d";
            hash = "sha256-fzTwVG0lxSBh7F3A7nHET9Makh+UrIaIXjF/sc9Z5A0=";
          };
          file = "package/Gleam.sublime-syntax";
        };
      };
    };
}
