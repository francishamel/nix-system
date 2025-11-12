{ inputs, ... }:

{
  flake.modules.homeManager.base = {
    imports = [ inputs.try.homeModules.default ];

    programs.try.enable = true;
  };
}
