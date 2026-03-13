{
  nixpkgs.allowedUnfreePackages = [
    "obsidian"
  ];

  flake.modules.homeManager.base = {
    programs.obsidian = {
      enable = true;

      defaultSettings = {
        app = {
          spellcheck = true;
        };

        appearance = {
          colorScheme = "obsidian";
        };

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

      # Initialize vault
      vaults."vaults/notes" = { };
    };
  };
}
