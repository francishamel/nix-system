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

            # The writing style rules are based on ISO 24495-1:2023 (Plain
            # language, Part 1) and Orwell's 1946 rules from "Politics and the
            # English Language". Neither name is in the rules themselves: the
            # bullets are more specific than either source, so the citation
            # would not change how Claude behaves.
            context = # markdown
              ''
                - Writing style. Applies to all prose you write for me: replies, code comments, commit messages, PR descriptions, and docs. It does not apply to code itself.
                  - Answer the question, then stop. Do not add sections, background, or options I did not ask for.
                  - If you cut something relevant, end with one short line that names it, so I can ask. Skip that line when there is nothing real to offer.
                  - Wording rules:
                    - Sentences under 20 words. Active voice. One idea per sentence.
                    - Prefer the everyday word when it means the same thing. Technical terms from the codebase or the domain are fine and often clearer.
                    - Same word for the same thing. No idioms.
                    - Cut filler and hedges. Do not pack more meaning into fewer words.
                    - Break one of these wording rules if following it makes the text unclear.
                  - Form rules, always — the escape hatch above does not apply to these:
                    - Use bullets for any list of three or more items.
                    - Keep paragraphs to three sentences or fewer.
                    - Use headings only when I asked several separate questions, one heading per question. Never use a heading for a topic I did not ask about.
                    - Use a table when comparing the same two or more facts across three or more items. Keep cells to a few words. If a cell needs a full sentence, use bullets instead.
              '';
          };
        };
      darwin.base.homebrew.casks = [ "claude" ];
    };
  };
}
