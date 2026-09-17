# CLAUDE.md

Nix-based macOS system config using flakes, nix-darwin, and home-manager. Follows the **dendritic pattern**: each `.nix` file under `modules/` is a flake-parts module exporting one feature across multiple configuration targets.

## Commands

Run `just` to see available commands.

## Key Architecture

**Every `.nix` file under `modules/`**, at any depth, is a flake-parts module that exports to one or more of:

- `flake.modules.darwin.base` — nix-darwin system config
- `flake.modules.homeManager.base` — home-manager, all platforms
- `flake.modules.homeManager.darwin` — macOS-specific

`import-tree` auto-imports those files recursively. Non-`.nix` files under `modules/` (`.py`, `.ts`, `.toml`, `.json`) are assets a sibling module references, not modules.

`modules/host-helpers.nix` builds the system — `mkDarwinHost` feeds `flake.modules.darwin.base` to `darwinSystem`. `hosts/flake-module.nix` names the host and adds per-host overrides. `modules/home-manager.nix` pulls the two `homeManager` targets into that system.

**`dev/` is not `modules/`**: files there configure _this repo_ — formatter, git hooks, `verify-refactor`. They write `perSystem` and touch no machine. Own `import-tree` call in `flake.nix`.

**Cross-module sharing** uses `flake.meta.*` — no `specialArgs` needed. Each option is declared in the module that sets it, so `nix eval .#meta` reports the whole contract. See `modules/user.nix` (defines) and `modules/git.nix` (reads) for the pattern.

**Unfree packages**: add to `nixpkgs.allowedUnfreePackages` in the relevant module; `modules/unfree-packages.nix` aggregates them.

**Global nix settings**: add to `nix.settings` in any module; `modules/settings.nix` propagates them.

**zsh startup**: never write a bare `programs.zsh.initContent`. Pick a slot from `flake.meta.zsh.initOrder` and wrap the block in `lib.mkOrder`. The four slots and the reason for each number live in `modules/zsh.nix`.

## Gotchas

- Hostname in `hosts/flake-module.nix` must match the system hostname
- User config (username, git email, GitHub handle) lives in `modules/user.nix`
- Always check existing modules with `rg "programs\." modules/` before adding new ones
