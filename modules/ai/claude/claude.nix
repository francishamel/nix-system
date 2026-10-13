{ inputs, ... }:
{
  nixpkgs.allowedUnfreePackages = [ "claude-code" ];

  flake = {
    modules = {
      homeManager.base =
        { pkgs, ... }:
        {
          programs.claude-code = {
            enable = true;
            package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.claude-code;
            settings = {
              # Empty string hides the attribution. `includeCoAuthoredBy` does the
              # same thing but is deprecated in favour of this.
              attribution = {
                commit = "";
                pr = "";
              };

              promptSuggestionEnabled = false;

              # Built-in output style: short replies, no preamble or narration.
              outputStyle = "Concise";
            };

            # The writing style rules are based on ISO 24495-1:2023 (Plain
            # language, Part 1) and Orwell's 1946 rules from "Politics and the
            # English Language". Neither name is in the rules themselves: the
            # bullets are more specific than either source, so the citation
            # would not change how Claude behaves.
            context = # markdown
              ''
                - **ALWAYS** start a PR reply with `Claude here 🤖:` and end it with `🤖 Addressed by Claude Code`. A reply is a comment or a review comment on a PR. Never put either line in the PR description.
              '';
          };
        };
      darwin.base.homebrew.casks = [ "claude" ];
    };
  };
}
