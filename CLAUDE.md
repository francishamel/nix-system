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

`hosts/flake-module.nix` builds the system. It names the host and feeds `flake.modules.darwin.base` to `darwinSystem`, alongside the per-host overrides. `modules/system/home-manager.nix` pulls the two `homeManager` targets into that system.

**Directories under `modules/` are navigation only.** `import-tree` assigns them no meaning — it walks the tree and merges whatever it finds. A subject earns a folder once it has several files. The rule guides new folders; the single-file folders already in the tree are fine and need no flattening.

- `modules/nix/` — nix itself: settings, garbage collection, caches, the unfree allowlist, the index
- `modules/system/` — the machine: the user, darwin defaults, home-manager, homebrew, state version
- `modules/` — programs, one file each

**`dev/` is not `modules/`**: files there configure _this repo_ — formatter, git hooks, `verify-refactor`. They write `perSystem` and touch no machine. Own `import-tree` call in `flake.nix`.

**Cross-module sharing** uses two namespaces, and neither needs `specialArgs`. Both declare each option in the module that sets it.

- `flake.meta.*` — facts worth querying from outside, like the user and the nixpkgs config. It is a flake output, so `nix eval .#meta` reports the whole contract. See `modules/system/user.nix` (defines) and `modules/git.nix` (reads).
- `my.*` — internal plumbing, never a flake output. Use it when the value only matters inside this flake. It lives at two unrelated levels: `my.zsh.initOrder` is a top-level flake-parts option that six other modules read; `my.onepassword` is a home-manager option that only `modules/onepassword.nix` uses, to keep a darwin-only path out of the shared config.

**Unfree packages**: add to `nixpkgs.allowedUnfreePackages` in the relevant module; `modules/nix/unfree-packages.nix` aggregates them.

**Global nix settings**: add to `nix.settings` in any module; `modules/nix/settings.nix` propagates them.

**zsh startup**: never write a bare `programs.zsh.initContent`. Pick a slot from `my.zsh.initOrder` and wrap the block in `lib.mkOrder`. The four slots and the reason for each number live in `modules/zsh.nix`.

## Gotchas

- Hostname in `hosts/flake-module.nix` must match the system hostname
- User config (username, git email, GitHub handle) lives in `modules/system/user.nix`
- Always check existing modules with `rg "programs\." modules/` before adding new ones
