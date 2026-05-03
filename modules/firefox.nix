{ inputs, ... }:
{
  nixpkgs.allowedUnfreePackages = [
    "onepassword-password-manager"
  ];

  flake.modules.darwin.base.nixpkgs.overlays = [ inputs.nur.overlays.default ];

  flake.modules.homeManager.base =
    { lib, pkgs, ... }:
    {
      # Many of these settings (default_area, autoDisableScopes, onboarding prefs) only
      # apply to a fresh profile. To apply changes from scratch: quit Firefox, then
      # `rm -rf ~/Library/Application\ Support/Firefox` and rebuild.
      programs.firefox = {
        enable = true;
        # Pin extensions to the navbar on first profile launch. installation_mode="allowed"
        # is a no-op carrier — install/enable is handled by extensions.packages + the
        # autoDisableScopes prefs below; this entry only exists to attach default_area.
        policies.ExtensionSettings = {
          "uBlock0@raymondhill.net" = {
            installation_mode = "allowed";
            default_area = "navbar";
          };
          "{d634138d-c276-4fc8-924b-40a0ea21d284}" = {
            installation_mode = "allowed";
            default_area = "navbar";
          };
          "clipper@obsidian.md" = {
            installation_mode = "allowed";
            default_area = "navbar";
          };
        };
        profiles.default = {
          id = 0;
          isDefault = true;
          extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            onepassword-password-manager
            web-clipper-obsidian
          ];
          search = {
            force = true;
            default = "ddg";
            engines =
              lib.genAttrs
                [
                  "amazondotcom-us"
                  "bing"
                  "ebay"
                  "google"
                  "perplexity"
                  "wikipedia"
                ]
                (_: {
                  metaData.hidden = true;
                });
          };
          settings = {
            # Auto-enable side-loaded (nix-installed) extensions instead of requiring manual approval.
            # Both prefs are scope bitmasks (1=profile, 2=app, 4=user, 8=system):
            # autoDisableScopes=0 disables nothing; enabledScopes=15 (1+2+4+8) enables all scopes.
            "extensions.autoDisableScopes" = 0;
            "extensions.enabledScopes" = 15;

            # Skip first-run onboarding and post-update "What's New" pages.
            "browser.preonboarding.enabled" = false;
            "browser.aboutwelcome.enabled" = false;

            # Strip the new-tab page down — no weather widget, no shortcuts grid, no Pocket stories.
            "browser.newtabpage.activity-stream.showWeather" = false;
            "browser.newtabpage.activity-stream.feeds.topsites" = false;
            "browser.newtabpage.activity-stream.feeds.section.topstories" = false;

            # Strip URL bar suggestions down — no curated/sponsored picks, no other-engine prompts.
            "browser.urlbar.suggest.topsites" = false;
            "browser.urlbar.quicksuggest.enabled" = false;
            "browser.urlbar.suggest.engines" = false;

            # Suppress the Mozilla privacy-notice tab opened on first run.
            "datareporting.policy.firstRunURL" = "";

            # Disable all telemetry, studies, and data reporting.
            "datareporting.policy.dataSubmissionEnabled" = false;
            "datareporting.healthreport.uploadEnabled" = false;
            "toolkit.telemetry.enabled" = false;
            "toolkit.telemetry.unified" = false;
            "toolkit.telemetry.archive.enabled" = false;
            "app.shield.optoutstudies.enabled" = false;
            "app.normandy.enabled" = false;
            "browser.ping-centre.telemetry" = false;

            # Cmd+W on the last tab clears the tab instead of closing the window.
            "browser.tabs.closeWindowWithLastTab" = false;

            # Disable Firefox Accounts entirely — removes the toolbar account icon and sync UI.
            "identity.fxaccounts.enabled" = false;

            # Always restore the previous session's tabs on launch.
            "browser.startup.page" = 3;

            # Skip the "Quit Firefox or close current tab?" prompt on Cmd+Q.
            "browser.warnOnQuitShortcut" = false;
          };
        };
      };
    };
}
