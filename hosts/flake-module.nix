{ self, ... }:

{
  flake.darwinConfigurations = {
    francis-atob-macbook-pro = self.lib.mkDarwinHostAarch64 {
      hostname = "francis-atob-macbook-pro";
    };
  };
}
