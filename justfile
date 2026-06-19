[private]
default:
  @just --list

alias dr := darwin-rebuild
alias f := format
alias fc := flake-checker
alias u := update

darwin-rebuild:
  @sudo darwin-rebuild switch --flake .#

flake-checker:
  @nix run github:DeterminateSystems/flake-checker -- --no-telemetry

format:
  @nix fmt

update:
  @nix flake update
