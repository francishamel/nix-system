# macbook-nix

This is my Intel MacBook Pro nix configuration. I'm using [nix-darwin](https://github.com/LnL7/nix-darwin) and [home-manager](https://github.com/nix-community/home-manager). As of January 23 2022, this configuration uses homebrew for GUI applications since there is a problem with Spotlight not being able to find GUI apps that are installed via nix.

## How to do a fresh install

Prerequiste: you need an user named `francis`.

### Install nix-darwin and home-manager

Following this blogpost: https://hardselius.github.io/2020/nix-please/

1. Run `sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume --daemon` to install nix
2. Backing a file
    1. `sudo mv /etc/nix/nix.conf /etc/nix/nix.conf.orig`
3. `Install nix-darwin`
    1. Download it: `nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer`
    2. Run the script: `./result/bin/darwin-installer`
        1. `N`
        2. `Y`
        3. `Y`
        4. `Y`
        5. `Y`
4. Install home-manager
    1. Install home-manager channel
        1. `nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager`
        2. `nix-channel --update`

### Clone the repo

1. Open terminal
2. Go to `.nixpkgs` directory using `cd ~/.nixpkgs`
3. Run `nix-shell -p git` to open a shell with git
4. Run `git clone`

### Apply the config

Run `darwin-rebuild switch` to apply the configuration from this repository on the Mac.


### See applications in Raycast

1. Apply the new config
2. Do `which alacritty` to see the symlink
3. `ll` the link returned by the previous line
4. Go to this path and find the `Applications` folder
5. Add the Applications folder link to the Raycast config
