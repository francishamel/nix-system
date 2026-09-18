{ lib, ... }:
{
  flake.modules.homeManager.base =
    { config, ... }:
    {
      programs = {
        delta = {
          enable = true;
          enableGitIntegration = true;
          options = {
            line-numbers = true;
            navigate = true;
            side-by-side = true;
          };
        };

        lazygit.settings.git.diffRenderers = [
          {
            command = "${lib.getExe config.programs.delta.package} --dark --paging=never --line-numbers --hyperlinks --hyperlinks-file-link-format=\"lazygit-edit://{path}:{line}\"";
          }
        ];
      };
    };
}
