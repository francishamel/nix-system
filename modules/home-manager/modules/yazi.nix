{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      open = {
        prepend_rules = [
          {
            mime = "application/pdf";
            use = [ "pdff" ];
          }
        ];
      };
      opener = {
        pdff = [
          {
            run = "${pkgs.zathura}/bin/zathura --mode fullscreen \"$@\"";
            desc = "zathura";
            block = true;
          }
        ];
      };
    };
  };
}
