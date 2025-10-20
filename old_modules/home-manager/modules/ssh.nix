{ ... }:

{
  programs.ssh = {
    enable = true;
    hashKnownHosts = true;
    controlPath = "~/.ssh/master";
  };
}
