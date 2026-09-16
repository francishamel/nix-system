{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      programs.claude-code = {
        # `plugins.*` wraps the source in a directory of top-level symlinks, which
        # makes the paths in this plugin's `skills` manifest resolve outside the
        # plugin directory. Claude then drops every skill. The marketplace route
        # points at the store path directly, so the paths stay inside.
        marketplaces.mattpocock = pkgs.fetchFromGitHub {
          owner = "mattpocock";
          repo = "skills";
          rev = "v1.2.3";
          hash = "sha256-I/EXHGW92nXz6JCLp8SKGgzXrbbUTkLAfxv8bc/ThwQ=";
        };

        settings.enabledPlugins = {
          "mattpocock-skills@mattpocock" = true;
        };
      };
    };
}
