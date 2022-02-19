{ pkgs, ... }:

{
  homebrew = {
    brews = [ "inetutils" "truncate" ];
    casks = [ "burp-suite" ];
  };
}
