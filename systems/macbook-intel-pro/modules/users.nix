{ pkgs, ... }:

{
  users.users.francis = {
    uid = 501;
    createHome = true;
    home = "/Users/francis";
    shell = pkgs.zsh;
    isHidden = false;
  };

  users.knownUsers = [ "francis" ];
}
