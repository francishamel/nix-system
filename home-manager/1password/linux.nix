{ ... }:

{
  imports = [ ./common.nix ];

  # TODO: configure this properly for Linux
  _1password = {
    sockPath = "";
    sshProgram = "";
  };
}
