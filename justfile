[private]
default:
  @just --list

alias a := activate
alias f := format
alias u := update

activate:
  @nix run .#activate

# update:
#   @nix run .#update

update:
  @nix flake update nixpkgs home-manager treefmt-nix flake-parts

format:
  @nix fmt
