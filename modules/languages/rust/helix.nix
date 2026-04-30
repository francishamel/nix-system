{
  flake.modules.homeManager.base.programs.helix.languages = {
    language-server.rust-analyzer.config = {
      cargo.buildScripts.enable = true;
      diagnostics.experimental.enable = true;
      procMacro.enable = true;
    };
    language = [
      {
        name = "rust";
        auto-format = true;
      }
    ];
  };
}
