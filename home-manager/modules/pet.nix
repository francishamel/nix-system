{ ... }:

{
  programs.pet = {
    enable = true;

    snippets = [
      {
        command = "bin/rails g migration <name>";
        description = "Generate a Rails migration";
        tag = [ "rails" ];
      }
      {
        command = "bin/rails g maintenance_tasks:task <name>";
        description = "Generate a Rails maintenance task";
        tag = [ "rails" ];
      }
    ];
  };
}
