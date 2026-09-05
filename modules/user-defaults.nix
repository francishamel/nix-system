{ config, ... }:
{
  flake.modules.darwin.base =
    { pkgs, ... }:
    {
      programs.zsh.enable = true;
      users.users.${config.flake.meta.user.username}.shell = pkgs.zsh;
    };
}
