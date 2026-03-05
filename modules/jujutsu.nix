{ config, ... }:
{
  flake.modules.homeManager.base = {
    programs = {
      jujutsu = {
        enable = true;
        settings.user = {
          name = config.flake.meta.user.name;
          email = config.flake.meta.user.gitEmail;
        };
      };

      delta.enableJujutsuIntegration = true;

      jjui.enable = true;
    };
  };
}
