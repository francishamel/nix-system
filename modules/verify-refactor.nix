{
  perSystem =
    { pkgs, ... }:
    {
      packages.verify-refactor = pkgs.writeShellApplication {
        name = "verify-refactor";
        runtimeInputs = [
          pkgs.git
          pkgs.nix-diff
        ];
        text = ''
          ref="''${1:-main}"

          if ! root=$(git rev-parse --show-toplevel 2>/dev/null); then
            echo "not inside a git repository" >&2
            exit 1
          fi
          cd "$root"

          # Flakes only see tracked files, so an unstaged new module evaluates as
          # absent — the refactor would look like a clean no-op while silently
          # dropping config.
          untracked=$(git ls-files --others --exclude-standard -- '*.nix')
          if [ -n "$untracked" ]; then
            echo "untracked .nix files are invisible to nix — run 'git add -N' on:" >&2
            while IFS= read -r file; do
              printf '  %s\n' "$file" >&2
            done <<<"$untracked"
            exit 1
          fi

          rev=$(git rev-parse --verify "$ref")
          attr="darwinConfigurations.$(hostname -s).config.system.build.toplevel.drvPath"

          # ?rev= rather than ?ref= so any commit-ish resolves, not just branches and tags.
          base=$(nix eval --raw "git+file://$root?rev=$rev#$attr")
          tree=$(nix eval --raw ".#$attr")

          echo "baseline ($ref ''${rev:0:7}): $base"
          echo "working tree:            $tree"
          echo

          if [ "$base" = "$tree" ]; then
            echo "identical — the working tree does not change the built system"
            exit 0
          fi

          nix-diff --line-oriented --context 2 --skip-already-compared "$base" "$tree"
        '';
      };
    };
}
