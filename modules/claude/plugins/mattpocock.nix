{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      programs.claude-code.plugins.mattpocock-skills = pkgs.fetchFromGitHub {
        owner = "mattpocock";
        repo = "skills";
        rev = "v1.2.3";
        hash = "sha256-I/EXHGW92nXz6JCLp8SKGgzXrbbUTkLAfxv8bc/ThwQ=";
      };
    };
}
