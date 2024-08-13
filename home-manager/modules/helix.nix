{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt";
        }
      ];
    };
    settings = {
      editor.line-number = "relative";
    };
  };
}
