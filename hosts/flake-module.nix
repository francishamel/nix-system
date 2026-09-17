{ self, ... }:

{
  flake.darwinConfigurations = {
    francis-atob-macbook-pro = self.lib.mkDarwinHost {
      hostname = "francis-atob-macbook-pro";
      modules = [
        # An MDM tool force-installs 1Password.app on this machine, so nix must
        # not write over it. That app still supplies op-ssh-sign.
        { programs._1password-gui.enable = false; }
      ];
    };
  };
}
