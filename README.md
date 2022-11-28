# nix-system

`nix-system` contains different configs for different nix use cases.

## Installation from scratch

TODO

## Custom modules

The `modules` folder contains custom modules that extends `darwin`, `home-manager` and `nixos` base modules. They are an opiniated implementation of all the modules I usually use.

The `profiles` folder groups different concepts together. These profiles are then imported in the `configs`.

## Inspiration

- The modules organization is highly inspired from [lukebfox](https://github.com/lukebfox)'s [`nix-configs`](https://github.com/lukebfox/nix-configs) repo.
