[private]
default:
  @just --list

activate:
  @nix run .#activate

update:
  @nix run .#update

format:
  @nix fmt
