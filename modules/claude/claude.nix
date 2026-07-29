{ inputs, ... }:
{
  nixpkgs.allowedUnfreePackages = [ "claude-code" ];

  nix.settings = {
    extra-substituters = [ "https://cache.numtide.com" ];
    extra-trusted-public-keys = [ "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g=" ];
  };

  flake = {
    modules = {
      homeManager.base =
        { pkgs, ... }:
        {
          programs.claude-code = {
            enable = true;
            package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.claude-code;

            # Empty string hides the attribution. `includeCoAuthoredBy` does the
            # same thing but is deprecated in favour of this.
            settings.attribution = {
              commit = "";
              pr = "";
            };

            context = # markdown
              ''
                - Write in ASD-STE100 Simplified Technical English: short sentences (20 words max), active voice, one idea per sentence, simple words. No idioms, no figures of speech, no clever phrasing. Technical names and verbs from the codebase are fine.
                  This applies to all prose you write for me: replies, code comments, commit messages, PR descriptions, and docs. It does not apply to code itself.
                - **NEVER** use `python` or `python3`
                - For JSON, use `jq` (already available). It handles nearly everything.
              '';
          };
        };
      darwin.base.homebrew.casks = [ "claude" ];
    };
  };
}
