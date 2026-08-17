{ lib, ... }:
{
  flake.modules = {
    darwin.base.homebrew = {
      enable = true;
      onActivation = {
        autoUpdate = false;
        cleanup = "zap";
        upgrade = false;
      };
    };

    homeManager.darwin.programs.zsh.initContent = lib.mkBefore ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
  };
}
