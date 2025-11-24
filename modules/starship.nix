{
  flake.modules.homeManager.base = {
    programs.starship = {
      enable = true;
      settings = builtins.readFile ./starship/starship.toml |> builtins.fromTOML;
    };
  };
}
