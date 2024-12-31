{ pkgs, ... }:

{
  programs = {
    pet = {
      enable = true;

      snippets = [
        {
          command = "bin/rails g migration <name>";
          description = "Generate a Rails migration";
          tag = [ "rails" "db" ];
        }
        {
          command = "bin/rails g maintenance_tasks:task <name>";
          description = "Generate a Rails maintenance task";
          tag = [ "rails" ];
        }
        {
          command = "bin/rails db:migrate:status";
          description = "Display status of Rails migrations";
          tag = [ "rails" "db" ];
        }
        {
          command = "bin/rails db:migrate:down VERSION=<migration version>";
          description = "Rollback a specific Rails db migration";
          tag = [ "rails" "db" ];
        }
        {
          command = "bin/rails db:rollback STEP=<step=1>";
          description = "Rollback STEP Rails db migration(s)";
          tag = [ "rails" "db" ];
        }
      ];
    };

    zsh.shellAliases."pe" = "${pkgs.pet}/bin/pet exec";
  };
}
