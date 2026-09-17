# nix-system

Nix-based system configuration using flakes, nix-darwin, and home-manager. Organized using the [dendritic pattern](https://github.com/mightyiam/dendritic).

## Supported Architectures

- **aarch64-darwin** (Apple Silicon)

## Installation from Scratch

1. [Install Nix](https://nixos.org/download#nix-install-macos)
2. Clone this repo
3. Update hostname in `hosts/flake-module.nix` to match your system by running: `hostname`
4. Update username in `modules/system/user.nix`
5. Run initial build: `nix run --extra-experimental-features 'nix-command flakes' nix-darwin -- switch --flake .#`

## Adding New Hosts

Add a configuration in `hosts/flake-module.nix`:

```nix
let
  hostname = "new-hostname";
in
{
  flake.darwinConfigurations.${hostname} = inputs.nix-darwin.lib.darwinSystem {
    modules = [
      self.modules.darwin.base
      {
        nixpkgs.hostPlatform = "aarch64-darwin";
        networking.hostName = hostname;
      }
    ];
  };
}
```

`self.modules.darwin.base` carries every module in the flake. The inline attrset holds only what this host needs: its platform, its hostname, and any per-host override. `modules/system/home-manager.nix` wires home-manager into that system, using the user from `modules/system/user.nix`.

## Module Organization

All configuration lives in `modules/`, one file per subject, following the dendritic pattern. Each file exports to one or more targets (`darwin.base`, `homeManager.base`, `homeManager.darwin`). Directories are navigation only. See `CLAUDE.md` for detailed architecture documentation.
