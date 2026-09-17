{ inputs, self, ... }:

let
  hostname = "francis-atob-macbook-pro";
in
{
  flake.darwinConfigurations.${hostname} = inputs.nix-darwin.lib.darwinSystem {
    modules = [
      self.modules.darwin.base
      {
        nixpkgs.hostPlatform = "aarch64-darwin";
        networking.hostName = hostname;

        # An MDM tool force-installs 1Password.app on this machine, so nix must
        # not write over it. That app still supplies op-ssh-sign.
        programs._1password-gui.enable = false;
      }
    ];
  };
}
