{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    let
      mattpocock-skills = pkgs.fetchFromGitHub {
        owner = "mattpocock";
        repo = "skills";
        rev = "v1.1.0";
        hash = "sha256-XqF709Y9GMKINzZITlbCTyatG9AxRZh0qn2vcv1Z8yo=";
      };
    in
    {
      programs.claude-code.plugins = [ mattpocock-skills ];
    };
}
