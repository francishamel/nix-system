{ ... }:
{
  # Mouse settings
  system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = false;
  system.defaults.NSGlobalDomain."com.apple.trackpad.scaling" = 1.25;

  system.defaults.dock = {
    autohide = true;
    autohide-delay = 0.1;
    autohide-time-modifier = 0.5;
    enable-spring-load-actions-on-all-items = false;
    launchanim = false;
    mru-spaces = false;
    show-process-indicators = false;
    static-only = true;
  };

  system.defaults.finder = {
    AppleShowAllExtensions = true;
    FXEnableExtensionChangeWarning = false;
    QuitMenuItem = true;
  };

  # Sound settings
  system.defaults.".GlobalPreferences"."com.apple.sound.beep.sound" = "/System/Library/Sounds/Blow.aiff";

  system.defaults.loginwindow.GuestEnabled = false;
}
