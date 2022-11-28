#! /bin/bash

if [[ $(git diff --stat) != '' ]]; then
  echo 'Error: git tree is dirty. Stage and/or stash your changes before proceeding.'
else
  # Inject all the secret files
  op inject -f --in-file=profiles/home-manager/personal/default.nix --out-file=profiles/home-manager/personal/default.nix

  # Run darwin-rebuild
  darwin-rebuild switch --flake .#

  # Revert changes to remove secrets
  git restore .
fi
