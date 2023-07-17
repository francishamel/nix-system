{ ... }:

{
  imports = [ ./common.nix ];

  # Disable last login message
  home.file.".hushlogin".text = "";
}
