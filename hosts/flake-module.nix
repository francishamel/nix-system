{ self, ... }:

{
  flake.darwinConfigurations = {
    francis-atob-macbook-pro = self.lib.mkDarwinHost {
      hostname = "francis-atob-macbook-pro";
    };
  };
}
