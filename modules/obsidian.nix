{
  nixpkgs.allowedUnfreePackages = [
    "obsidian"
  ];

  # Temporary backport of https://github.com/NixOS/nixpkgs/pull/548462 — the darwin
  # build sets sourceRoot to the .app bundle, then copies its contents one level too
  # deep. The fix merged to master on 2026-08-03, a few hours after the commit our
  # nixpkgs-unstable is pinned to. Remove this overlay once the channel advances past
  # dea0d9eeca494734e596f3f4a813324d6af41265.
  flake.modules.darwin.base.nixpkgs.overlays = [
    (_final: prev: {
      obsidian = prev.obsidian.overrideAttrs (old: {
        sourceRoot = null;
        installPhase = ''
          runHook preInstall
          mkdir -p $out/{Applications,bin}
          cp -R ${old.appname}.app $out/Applications
          makeWrapper $out/Applications/${old.appname}.app/Contents/MacOS/${old.appname} $out/bin/obsidian
          makeWrapper $out/Applications/${old.appname}.app/Contents/MacOS/obsidian-cli $out/bin/obsidian-cli
          runHook postInstall
        '';
      });
    })
  ];

  flake.modules.homeManager.base = {
    programs.obsidian = {
      enable = true;

      cli.enable = true;

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
