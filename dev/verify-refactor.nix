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

          host=$(hostname -s)

          # A hostname that names no host is just a missing attribute to nix, so
          # it reports the attribute path and nothing about the machine's name.
          hosts=$(nix eval --raw ".#darwinConfigurations" --apply 'c: builtins.concatStringsSep " " (builtins.attrNames c)')
          case " $hosts " in
            *" $host "*) ;;
            *)
              echo "this machine is '$host', and the flake defines no host by that name" >&2
              echo "  hosts in the flake: $hosts" >&2
              echo "  fix: rename the host in hosts/flake-module.nix, or set this machine's hostname to one of them" >&2
              exit 1
              ;;
          esac

          rev=$(git rev-parse --verify "$ref")
          attr="darwinConfigurations.$host.config.system.build.toplevel.drvPath"

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

          # import-tree walks modules/ lexicographically, so moving a file moves
          # its entries inside the merged package lists. buildEnv hashes that
          # order, which makes a pure rename look like a changed system even
          # though the environment holds exactly the same store paths.
          packages() {
            nix eval --raw "$1#darwinConfigurations.$host.config" --apply '
              config:
              let
                users = builtins.attrValues (config.home-manager.users or { });
                lists = [ config.environment.systemPackages ] ++ builtins.map (u: u.home.packages) users;
                paths = builtins.concatMap (l: builtins.map toString l) lists;
              in
              builtins.concatStringsSep "\n" (builtins.sort builtins.lessThan paths)
            '
          }

          mapfile -t basePkgs < <(packages "git+file://$root?rev=$rev")
          mapfile -t treePkgs < <(packages ".")

          declare -A inBase inTree
          for p in "''${basePkgs[@]}"; do inBase["$p"]=1; done
          for p in "''${treePkgs[@]}"; do inTree["$p"]=1; done

          same=1
          for p in "''${basePkgs[@]}"; do
            if [ -z "''${inTree[$p]:-}" ]; then
              same=0
              echo "  removed: ''${p##*/}"
            fi
          done
          for p in "''${treePkgs[@]}"; do
            if [ -z "''${inBase[$p]:-}" ]; then
              same=0
              echo "  added:   ''${p##*/}"
            fi
          done

          if [ "$same" = 1 ]; then
            echo "same packages, different order — all ''${#basePkgs[@]} store paths match"
            echo "a file move reorders the merged lists, and buildEnv hashes the order"
          else
            echo
            echo "the package sets above differ, so this is not a pure reordering"
          fi
          echo

          nix-diff --line-oriented --context 2 --skip-already-compared "$base" "$tree"
        '';
      };
    };
}
