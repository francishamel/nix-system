{
  flake.modules.homeManager.base.programs.obsidian.defaultSettings.hotkeys = {
    "app:toggle-left-sidebar" = [
      {
        modifiers = [ "Mod" ];
        key = "[";
      }
    ];
    "app:toggle-right-sidebar" = [
      {
        modifiers = [ "Mod" ];
        key = "]";
      }
    ];
    "editor:swap-line-down" = [
      {
        modifiers = [ "Alt" ];
        key = "j";
      }
    ];
    "editor:swap-line-up" = [
      {
        modifiers = [ "Alt" ];
        key = "k";
      }
    ];
  };
}
