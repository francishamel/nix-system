# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Nix-based system configuration repository managing macOS development environments using flakes, nix-darwin, and home-manager. It follows the **dendritic pattern** (https://github.com/mightyiam/dendritic), where each module file is a top-level flake-parts module that defines one feature across all applicable configurations.

## Common Commands

### Building and Switching Configuration
```bash
# Rebuild and switch the darwin configuration (requires sudo)
just darwin-rebuild
# Or directly:
sudo darwin-rebuild switch --flake .#

# The hostname in hosts/flake-module.nix must match the system hostname
# Current configured hostname: "clicknpark-macbook"
```

### Formatting
```bash
# Format all files using treefmt (nixfmt, deadnix, prettier, stylua, taplo)
just format
# Or:
nix fmt

# Check formatting
nix flake check
```

### Updating Dependencies
```bash
# Update all flake inputs
just update
# Or:
nix flake update
```

## Architecture: The Dendritic Pattern

### Core Principle

Every file in `modules/` is a **top-level flake-parts module** that defines one feature. Files don't nest by type—instead they're organized by feature, with each file exporting to the appropriate `flake.modules.*` namespace.

### Module Organization

**Top-level imports:**
- `flake.nix` imports `hosts/flake-module.nix` and `(import-tree ./modules)`
- `import-tree` automatically imports all `.nix` files in `modules/`, making them flake-parts modules

**Module export pattern** (each file exports to one or more targets):
```nix
# modules/sometool.nix
{
  # Can configure global nix settings
  nix.settings = { ... };

  # Export to different configuration types
  flake.modules = {
    darwin.base = { ... };        # System-level macOS config
    homeManager.base = { ... };   # User environment (all platforms)
    homeManager.darwin = { ... }; # macOS-specific user config
    homeManager.gui = { ... };    # GUI-only config
  };
}
```

**Host composition** (in `hosts/flake-module.nix`):
```nix
darwinConfigurations.${hostname} = darwinSystem {
  modules = [
    self.modules.darwin.base  # Aggregates all darwin.base exports
    inputs.home-manager.darwinModules.home-manager
    {
      home-manager.users.${user}.imports = [
        self.modules.homeManager.base       # All homeManager.base exports
        self.modules.homeManager.darwin     # macOS-specific exports
        self.modules.homeManager.darwinAarch64  # Apple Silicon
        self.modules.homeManager.gui        # GUI apps
      ];
    }
  ];
}
```

### Module Namespaces

- `flake.modules.darwin.base` - nix-darwin system configuration
- `flake.modules.homeManager.base` - home-manager config for all platforms
- `flake.modules.homeManager.darwin` - macOS-specific home-manager
- `flake.modules.homeManager.darwinAarch64` - Apple Silicon-specific
- `flake.modules.homeManager.gui` - GUI applications

### Cross-Module Communication

**Via `flake.meta.*`**: Shared configuration is stored in the top-level `flake.meta` attribute set (defined in `modules/meta-output.nix`). This allows all modules to read and write shared values without `specialArgs`.

Example:
```nix
# modules/user.nix defines:
flake.meta.user = { username = "..."; gitEmail = "..."; };

# modules/git.nix reads it:
{ config, ... }: {
  flake.modules.homeManager.base.programs.git.userEmail =
    config.flake.meta.user.gitEmail;
}
```

**Via top-level options**: Modules like `modules/settings.nix` and `modules/unfree-packages.nix` define top-level options that aggregate values across all modules.

### Directory Organization

- `modules/` - Tool and feature configurations (flat or by category)
- `modules/languages/*/` - Language-specific tooling
- `modules/templates/` - Flake templates for new projects
- `hosts/` - Host-specific configurations that import module collections

## Working with Modules

### Adding a New Tool/Feature

1. Create `modules/newtool.nix`
2. Export to appropriate namespace(s):
   ```nix
   {
     flake.modules.homeManager.base = {
       programs.newtool.enable = true;
     };
   }
   ```
3. Stage the file with git for Nix flakes to recognize it:
   ```bash
   git add modules/newtool.nix
   ```
   **Important**: Nix flakes only recognize git-tracked files. New modules won't be imported until staged, even if they exist on disk.
4. Test changes:
   ```bash
   nix flake check  # Verify syntax
   just darwin-rebuild  # Test the full configuration
   ```
5. Module is automatically imported by `import-tree` once tracked

### Language Support Pattern

Language modules typically include:
1. Tool configuration in the main file or subdirectory
2. `helix.nix` for editor integration
3. Both export to `homeManager.base` or more specific namespaces

Example structure:
```
modules/languages/mylang/
  default.nix or mylang.nix  # Tool setup
  helix.nix                  # Editor config
```

### Allowing Unfree Packages

Add package name to `nixpkgs.allowedUnfreePackages` in the module that needs it:
```nix
{
  nixpkgs.allowedUnfreePackages = [ "vscode" ];
  flake.modules.homeManager.base = { pkgs, ... }: {
    programs.vscode = { package = pkgs.vscode; };
  };
}
```

The `modules/unfree-packages.nix` module aggregates these into a unified allowlist.

### Global Nix Settings

Add settings to `nix.settings` in any module (commonly in `modules/settings.nix`):
```nix
{
  nix.settings = {
    substituters = [ "https://cache.example.org" ];
    trusted-public-keys = [ "..." ];
  };
}
```

Settings are automatically propagated to all module types by `modules/settings.nix`.

### User Configuration

Edit `modules/user.nix` to change:
- `username` - System username and home directory path
- `gitEmail` - Git commit email
- `name` - Full name
- `githubUsername` - GitHub username

This is read via `config.flake.meta.user` by other modules (git, GitHub CLI, etc.).

## Common Patterns

Quick reference for implementing common tasks. See referenced files for full context.

### Adding Tools and Scripts

**Custom shell script**: Use `pkgs.writeShellScriptBin` to create an executable
→ See: `modules/git-worktree-init.nix`

**Simple package**: Add to `home.packages` for basic CLI tools
→ See: `modules/choose.nix`, `modules/just.nix`, `modules/cachix.nix`

**Configured program**: Use `programs.<name>` when the tool has settings
→ See: `modules/search.nix` (ripgrep with args), `modules/lazygit.nix` (with config)

**System-level tool (macOS)**: Export to `darwin.base` for system services
→ See: `modules/onepassword.nix`

**GUI application (macOS)**: Use `darwin.base.homebrew.casks`
→ See: `modules/docker.nix`

### Shell Integration

**Aliases**: Define in `programs.zsh.shellAliases`
→ See: `modules/lazygit.nix` (line 18)

**Using `lib.getExe`**: Prefer over hardcoding paths for portability
→ See: `modules/lazygit.nix` (line 18)

### Finding Patterns

Search existing modules before creating new ones:
```bash
rg "writeShellScriptBin" modules/
rg "home.packages" modules/
rg "programs\." modules/
```

## Multi-System Support

Supported systems (defined in `modules/systems.nix`):
- aarch64-darwin (Apple Silicon)
- aarch64-linux
- x86_64-darwin (Intel Mac)
- x86_64-linux
