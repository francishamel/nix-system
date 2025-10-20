{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.repgrep ];

      programs = {
        fd.enable = true;

        ripgrep = {
          enable = true;
          arguments = [
            "--smart-case"
            "--hidden"
            "--glob=!.git/*"
          ];
        };

        ripgrep-all.enable = true;
      };
    };
}
