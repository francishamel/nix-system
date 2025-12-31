{ self, ... }:

{
  flake.darwinConfigurations = {
    clicknpark-macbook = self.lib.mkDarwinHostAarch64 {
      hostname = "clicknpark-macbook";
    };
  };
}
