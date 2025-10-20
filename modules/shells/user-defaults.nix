{
  flake.modules = {
    darwin.base =
      { pkgs, ... }:
      {
        programs.zsh.enable = true;
        users.users.francishamel.shell = pkgs.zsh;
      };
    nixos.base =
      { pkgs, ... }:
      {
        programs.zsh.enable = true;
        users.defaultUserShell = true;
        users.users.francishamel.shell = pkgs.zsh;
      };
  };
}
