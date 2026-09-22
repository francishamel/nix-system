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
            # TEMPORARY: pin 2.1.280 ahead of llm-agents.nix.
            #
            # Its updater runs on cron at 00:00, 04:00, 18:00 and 21:00 UTC, so
            # a release lands here up to six hours late. Revert this commit once
            # `just update-llm-agents` brings in 2.1.280 or newer.
            #
            # The package downloads a prebuilt binary from Anthropic's release
            # bucket, so only the version, the source and the codesign check
            # need replacing. The hash is the checksum from that version's
            # manifest.json in the same bucket, converted to SRI.
            package =
              let
                version = "2.1.280";
                src = pkgs.fetchurl {
                  url = "https://storage.googleapis.com/claude-code-dist-86c565f3-f756-42ad-8dfa-d59b1c096819/claude-code-releases/${version}/darwin-arm64/claude";
                  hash = "sha256-OHpcXc27gVCF7fC695WR+diJTv6SK86vPXWxsIBVIp0=";
                };
              in
              inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.claude-code.overrideAttrs (_: {
                inherit version src;
                codesignSources = [ src ];
              });

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

                - **ALWAYS** start a PR reply with `Claude here 🤖:` and end it with `🤖 Addressed by Claude Code`. A reply is a comment or a review comment on a PR. Never put either line in the PR description.
              '';
          };
        };
      darwin.base.homebrew.casks = [ "claude" ];
    };
  };
}
