# nix-system

`nix-system` contains different configs for different nix use cases.

## Installation from scratch

### MacOS

1. [Install nix](https://nixos.org/download#nix-install-macos)
2. Clone this repo
3. Change the config's hostname to the computer's hostname
4. Change the config's user to current user
5. Run `nix run --extra-experimental-features 'nix-command flakes' .#activate`
