{
  flake.modules.darwin.base.nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d";
  };
}
