{ ... }:
{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    let
      # Read-only `gh` wrapper for Claude. Converts an over-privileged classic
      # PAT (`repo` scope is read+write, no read-only variant) back into an
      # effective read boundary: only the explicitly-listed read subcommands
      # pass through, everything else is rejected. This is the real guardrail —
      # the Claude Bash allowlist is belt-and-suspenders on top.
      gh-ro = pkgs.writers.writePython3Bin "gh-ro" { flakeIgnore = [ "E501" ]; } ''
        import os
        import sys

        GH = "${pkgs.gh}/bin/gh"

        # top-level command -> allowed read-only subcommands
        ALLOWED = {
            "pr": {"view", "list", "checks", "diff", "status"},
            "run": {"view", "list"},
            "workflow": {"view", "list"},
            "search": {"prs", "issues"},
            "auth": {"status"},
        }


        def deny(reason):
            sys.stderr.write("gh-ro: blocked (%s)\n" % reason)
            sys.exit(1)


        def main():
            args = sys.argv[1:]
            if not args or args[0] in ("--version", "--help", "-h"):
                os.execv(GH, [GH] + args)
            cmd = args[0]
            subs = ALLOWED.get(cmd)
            if subs is None:
                deny("command %s not allowed" % cmd)
            sub = next((a for a in args[1:] if not a.startswith("-")), None)
            if sub not in subs:
                deny("%s %s not allowed" % (cmd, sub or ""))
            os.execv(GH, [GH] + args)


        main()
      '';
    in
    {
      home.packages = [ gh-ro ];

      programs.claude-code.context = # markdown
        ''
          - **GitHub**: never call `gh` directly — it is denied. Always use the read-only wrapper `gh-ro`, authenticated per-call by setting `GITHUB_TOKEN` to a 1Password `op://` reference and running through `op run`. Pick the reference/account by the repo's location:
            - Under `~/src/gh/AtoB-Developers/`:
              `GITHUB_TOKEN="op://Employee/Claude GitHub PAT/token" op run --account atob.1password.com -- gh-ro <args>`
            - Anywhere else:
              `GITHUB_TOKEN="op://Private/GitHub/cli/Token" op run --account my.1password.com -- gh-ro <args>`
            `gh-ro` only permits reading PRs (e.g. `pr view --comments`, `pr diff`, `pr checks`) and Actions runs (`run view`, `run list`). Never print or echo `GITHUB_TOKEN`.
        '';

      # Deny direct `gh` outright (enforced in every mode, incl. auto) so the
      # classic PAT's write capability is never reachable except through the
      # read-only wrapper. Allowing the wrapper path just avoids prompts.
      programs.claude-code.settings.permissions = {
        deny = [ "Bash(gh:*)" ];
        allow = [
          "Bash(gh-ro:*)"
          "Bash(op run -- gh-ro:*)"
        ];
      };
    };
}
