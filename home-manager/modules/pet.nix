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
    ];
  };
}
