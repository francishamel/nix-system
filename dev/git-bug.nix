{
  perSystem =
    { pkgs, ... }:
    {
      my.devShell.packages = [ pkgs.git-bug ];
    };
}
