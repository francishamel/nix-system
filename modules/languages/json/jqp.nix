{ inputs, ... }:

{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    let
      jqp = inputs.wrappers.lib.wrapPackage {
        inherit pkgs;
        package = pkgs.jqp;
        flags."--theme" = "nord";
      };
    in
    {
      home.packages = [ jqp ];
    };
}
