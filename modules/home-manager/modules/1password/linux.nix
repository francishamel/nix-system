{ config, ... }:

{
  imports = [ ./common.nix ];

  hm._1password = {
    sockPath = "${config.home.homeDirectory}/.1password/agent.sock";
    sshProgram = "/run/current-system/sw/bin/op-ssh-sign";
  };
}
