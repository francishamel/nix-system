{ inputs, ... }:

{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home = {
        packages = [
          (inputs.wrappers.lib.wrapPackage
            {
              inherit pkgs;
              package = pkgs.jqp;
              flags = {
                "--theme" = "nord";
              };
            })
        ];
      };

      programs.jq.enable = true;
    };
}
