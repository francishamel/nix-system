[private]
default:
  @just --list

alias dr := darwin-rebuild
alias f := format
alias u := update

darwin-rebuild:
  @darwin-rebuild switch --flake .#

update:
  @nix flake update nixpkgs nix-darwin home-manager treefmt-nix flake-parts

format:
  @nix fmt
