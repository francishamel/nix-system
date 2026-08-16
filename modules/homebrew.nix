{ lib, ... }:
{
  flake.modules = {
    darwin.base.homebrew = {
      enable = true;
      onActivation = {
        autoUpdate = false;
        cleanup = "zap";
        upgrade = false;
        # Homebrew 5.x requires --force-cleanup for non-interactive cleanup/zap.
        # Workaround until nix-darwin ships the fix.
        # https://github.com/nix-darwin/nix-darwin/issues/1787
        extraFlags = [ "--force-cleanup" ];
      };
    };

    homeManager.darwin.programs.zsh.initContent = lib.mkBefore ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
  };
}
