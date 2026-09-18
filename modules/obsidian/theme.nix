{
  flake.modules.homeManager.base = { pkgs, ... }: {
    programs.obsidian.defaultSettings = {
      appearance.colorScheme = "obsidian";

      themes = [ pkgs.obsidianThemes.minimal ];

      communityPlugins = [
        {
          pkg = pkgs.obsidianPlugins."obsidian-minimal-settings";
          settings = {
            lightScheme = "minimal-nord-light";
            darkScheme = "minimal-nord-dark";
          };
        }
      ];
    };
  };
}
