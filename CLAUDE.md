# CLAUDE.md

Nix-based macOS system config using flakes, nix-darwin, and home-manager. Follows the **dendritic pattern**: each file in `modules/` is a flake-parts module exporting one feature across multiple configuration targets.

## Commands

Run `just` to see available commands.

## Key Architecture

**Every `modules/*.nix` file** is a flake-parts module that exports to one or more of:
- `flake.modules.darwin.base` — nix-darwin system config
- `flake.modules.homeManager.base` — home-manager, all platforms
- `flake.modules.homeManager.darwin` — macOS-specific
- `flake.modules.homeManager.darwinAarch64` — Apple Silicon
- `flake.modules.homeManager.gui` — GUI apps

`hosts/flake-module.nix` aggregates these into the final system. `import-tree` auto-imports all `.nix` files in `modules/`.

**Cross-module sharing** uses `flake.meta.*` (defined in `modules/meta-output.nix`) — no `specialArgs` needed. See `modules/user.nix` (defines) and `modules/git.nix` (reads) for the pattern.

**Unfree packages**: add to `nixpkgs.allowedUnfreePackages` in the relevant module; `modules/unfree-packages.nix` aggregates them.

**Global nix settings**: add to `nix.settings` in any module; `modules/settings.nix` propagates them.

## Gotchas

- Hostname in `hosts/flake-module.nix` must match the system hostname (`clicknpark-macbook`)
- User config (username, git email, GitHub handle) lives in `modules/user.nix`
- Always check existing modules with `rg "programs\." modules/` before adding new ones
