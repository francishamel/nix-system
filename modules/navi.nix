{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      programs.navi = {
        enable = true;
        enableZshIntegration = true;
        settings.cheats.paths = [
          "${pkgs.fetchFromGitHub {
            owner = "denisidoro";
            repo = "cheats";
            rev = "1339965e9615ce00174cc308a41279d9c59aa75f";
            hash = "sha256-wPsAazAGKPhu0MZfZbZ0POUBEMg95frClAQERTDFXUg=";
          }}"
        ];
      };
    };
}
