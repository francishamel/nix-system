{
  flake.modules.homeManager.base.programs.helix.languages = {
    language-server.sorbet = {
      command = "srb";
      args = [
        "tc"
        "--lsp"
        # Watchman isn't installed; without this sorbet retries and warns.
        "--disable-watchman"
        "--enable-all-beta-lsp-features"
      ];
    };
    language = [
      {
        name = "ruby";
        language-servers = [ "sorbet" ];
      }
    ];
  };
}
