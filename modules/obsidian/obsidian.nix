{ inputs, ... }:
{
  flake.modules.darwin.base.nixpkgs.overlays = [
    inputs.obsidian-extensions.overlays.default
  ];

  nixpkgs.allowedUnfreePackages = [
    "obsidian"
  ];

  flake.modules.homeManager.base = {
    programs.obsidian = {
      enable = true;

      cli.enable = true;

      defaultSettings = {
        app.spellcheck = true;

        corePlugins = [
          {
            name = "backlink";
            enable = true;
          }
          {
            name = "command-palette";
            enable = true;
          }
          {
            name = "file-explorer";
            enable = true;
          }
          {
            name = "daily-notes";
            enable = true;
          }
        ];
      };

    };
  };
}
