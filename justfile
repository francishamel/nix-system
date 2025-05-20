[private]
default:
  @just --list

alias dr := darwin-rebuild
alias f := format
alias u := update

darwin-rebuild:
  @sudo darwin-rebuild switch --flake .#

update:
  @nix flake update

format:
  @nix fmt
