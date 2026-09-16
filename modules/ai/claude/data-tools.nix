{ ... }:
{
  # Claude must not use Python. These are the replacements, one per job. Nothing
  # is installed: `nix run` fetches each tool from the binary cache on demand,
  # which takes about two seconds. The rule and its allow list have to stay in
  # sync, so they live in the same file.
  flake.modules.homeManager.base = {
    programs.claude-code = {
      context = # markdown
        ''
          - **NEVER** use `python` or `python3`. Use these instead:
            - JSON: `jq`, already installed.
            - YAML: `nix run nixpkgs#yq-go -- <args>`
            - CSV and TSV: `nix run nixpkgs#qsv -- <args>`
            - Find and replace across files: `nix run nixpkgs#sd -- <args>`
        '';

      # Allow the three tools by name, not `nix run` as a whole. A broad
      # `Bash(nix run:*)` rule would let Claude run any package in nixpkgs
      # without asking.
      settings.permissions.allow = [
        "Bash(nix run nixpkgs#yq-go:*)"
        "Bash(nix run nixpkgs#qsv:*)"
        "Bash(nix run nixpkgs#sd:*)"
      ];
    };
  };
}
