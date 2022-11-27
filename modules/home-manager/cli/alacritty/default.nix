{ config, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.modules.cli.alacritty;
in
{
  options.modules.cli.alacritty.enable = mkEnableOption "Enable personal home-manager module for alacritty.";

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        # TODO: set this based on global theme
        # TODO: extract this to a themes folder + add more themes maybe
        # Solarized dark color scheme
        colors = {
          primary = {
            background = "#002b36";
            foreground = "#839496";
          };
          cursor = {
            text = "#002b36";
            cursor = "#839496";
          };
          normal = {
            black = "#073642";
            red = "#dc322f";
            green = "#859900";
            yellow = "#b58900";
            blue = "#268bd2";
            magenta = "#d33682";
            cyan = "#2aa198";
            white = "#eee8d5";
          };
          bright = {
            black = "#586e75";
            red = "#cb4b16";
            green = "#586e75";
            yellow = "#657b83";
            blue = "#839496";
            magenta = "#6c71c4";
            cyan = "#93a1a1";
            white = "#fdf6e3";
          };
        };

        font = {
          normal = {
            # TODO: set this based on theme config
            family = "FiraCode Nerd Font";
            style = "Retina";
          };

          size = 14.0;
        };

        window = {
          dynamic_title = false;
          startup_mode = "Maximized";
          title = "Alacritty";
        };
      };
    };
  };
}