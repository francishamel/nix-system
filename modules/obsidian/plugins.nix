{
  flake.modules.homeManager.base = { pkgs, ... }: {
    programs.obsidian.defaultSettings.communityPlugins = [
      { pkg = pkgs.obsidianPlugins."templater-obsidian"; }
      { pkg = pkgs.obsidianPlugins."obsidian-tasks-plugin"; }
      { pkg = pkgs.obsidianPlugins.quickadd; }
    ];
  };
}
