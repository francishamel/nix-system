{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.glow ];

      programs.zsh.initContent = ''
        alias -s md=glow
      '';
    };
}
