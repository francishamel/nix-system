# nix-system

Nix-based system configuration using flakes, nix-darwin, and home-manager. Organized using the [dendritic pattern](https://github.com/mightyiam/dendritic).

## Supported Architectures

- **aarch64-darwin** (Apple Silicon)
- **x86_64-darwin** (Intel Mac)

## Current Hosts

- `clicknpark-macbook` - aarch64-darwin (Apple Silicon)

## Installation from Scratch

1. [Install Nix](https://nixos.org/download#nix-install-macos)
2. Clone this repo: `git clone <your-repo-url> ~/.config/nix-system && cd ~/.config/nix-system`
3. Update hostname in `hosts/flake-module.nix` to match your system: `scutil --get LocalHostName`
4. Update username in `modules/user.nix`
5. Run initial build: `nix run --extra-experimental-features 'nix-command flakes' .#activate`

## Adding New Hosts

Add a new configuration in `hosts/flake-module.nix`:

### Apple Silicon (aarch64-darwin)

```nix
darwinConfigurations = {
  new-hostname = self.lib.mkDarwinHostAarch64 {
    hostname = "new-hostname";
  };
};
```

### Intel Mac (x86_64-darwin)

```nix
darwinConfigurations = {
  new-hostname = self.lib.mkDarwinHostX86_64 {
    hostname = "new-hostname";
  };
};
```

The helpers (defined in `modules/host-helpers.nix`) automatically:
- Include appropriate platform-specific modules for aarch64 or x86_64
- Include GUI applications (all macOS systems are desktop systems)
- Configure home-manager with the user from `modules/user.nix`
- Set up nixpkgs for the target platform

## Module Organization

All configuration lives in `modules/` as flat files following the dendritic pattern. Each module exports to appropriate namespaces (`darwin.base`, `homeManager.base`, etc.). See `CLAUDE.md` for detailed architecture documentation.
