{ config, lib, ... }:
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

    homeManager.darwin.programs.zsh.initContent = lib.mkOrder config.flake.meta.zsh.initOrder.path ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
  };
}
