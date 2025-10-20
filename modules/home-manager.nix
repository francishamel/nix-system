# TODO: look into configuring this in a better manner
{
  flake.modules.homeManager.base = {
    xdg.enable = true;
    home.stateVersion = "22.11";
  };
}
