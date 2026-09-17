{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      home.packages = [
        (pkgs.writeShellApplication {
          name = "nix-clean";
          runtimeInputs = [ pkgs.nix ];
          text = ''
            keep=3

            echo "Deleting old system generations (keeping last $keep)..."
            sudo -H nix-env --delete-generations "+$keep" --profile /nix/var/nix/profiles/system

            echo "Deleting old home-manager generations (keeping last $keep)..."
            nix-env --delete-generations "+$keep" --profile "$HOME/.local/state/nix/profiles/home-manager"

            echo "Running garbage collection..."
            sudo -H nix-collect-garbage -d

            echo "Done! Check space with: df -h"
          '';
        })
      ];
    };
}
