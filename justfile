[private]
default:
  @just --list

alias a := activate
alias f := format
alias u := update

activate:
  @nix run .#activate

update:
  @nix run .#update

format:
  @nix fmt
