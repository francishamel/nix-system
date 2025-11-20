{
  flake = rec {
    templates = {
      gleam = {
        path = ./_templates/gleam;
        description = "Gleam project, with devenv";
      };
    };

    om.templates = {
      gleam = {
        template = templates.gleam;
        params = [
          {
            name = "package-name";
            description = "Name of the Gleam package/app";
            placeholder = "template_gleam";
          }
          {
            name = "github-actions";
            description = "Include .github/ to configure GitHub Actions";
            paths = [ ".github" ];
            value = true;
          }
        ];
      };
    };
  };
}
