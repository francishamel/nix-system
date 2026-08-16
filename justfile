[private]
default:
  @just --list

alias dr := darwin-rebuild
alias f := format
alias fc := flake-checker
alias u := update
alias vr := verify-refactor

darwin-rebuild:
  @sudo darwin-rebuild switch --flake .#

flake-checker:
  @nix run github:DeterminateSystems/flake-checker -- --no-telemetry

format:
  @nix fmt

update:
  @nix flake update

update-llm-agents:
  @nix flake update llm-agents

# Show how the working tree changes the built system, against a baseline ref
verify-refactor ref="main":
  @nix run .#verify-refactor -- {{ ref }}
