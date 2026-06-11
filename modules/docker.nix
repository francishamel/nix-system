{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.docker
        pkgs.docker-compose
        pkgs.lazydocker
      ];
    };
  flake.modules.darwin.base.homebrew.casks = [ "docker-desktop" ];
}
