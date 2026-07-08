{
  # Just the "grill" skills from Matt Pocock's plugin, cherry-picked out of the
  # fetched source instead of loading the whole plugin — an allowlist, so none
  # of the other ~19 skills (tdd, code-review, domain-modeling, ...) load or
  # auto-trigger. `/grill-me` runs the interview loop (`/grilling`), which is
  # what I'm after. To re-enable everything, swap this `skills` block back for
  # `plugins = [ mattpocock-skills ];`. Bump rev/hash to update.
  # https://github.com/mattpocock/skills
  flake.modules.homeManager.base =
    { pkgs, ... }:
    let
      mattpocock-skills = pkgs.fetchFromGitHub {
        owner = "mattpocock";
        repo = "skills";
        rev = "d574778f94cf620fcc8ce741584093bc650a61d3";
        hash = "sha256-XqF709Y9GMKINzZITlbCTyatG9AxRZh0qn2vcv1Z8yo=";
      };
    in
    {
      programs.claude-code.skills = {
        grill-me = "${mattpocock-skills}/skills/productivity/grill-me";
        grilling = "${mattpocock-skills}/skills/productivity/grilling";
      };
    };
}
