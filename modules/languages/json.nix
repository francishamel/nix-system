{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home = {
        packages = [ pkgs.jqp ];

        # TODO: this is a styling concern
        file.".jqp.yaml".text = ''
          theme:
            name: "nord"
        '';
      };

      programs.jq.enable = true;
    };
}
