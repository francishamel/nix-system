{ pkgs, ... }:

{
  home.packages = [ pkgs.repgrep ];

  programs = {
    ripgrep = {
      enable = true;
      arguments = [
        "--smart-case"
        "--hidden"
        "--glob=!.git/*"
      ];
    };

    ripgrep-all.enable = true;
  };
}
