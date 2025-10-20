{ ... }:

{
  imports = [ ./common.nix ];

  # Disable last login message
  home.file.".hushlogin".text = "";

  programs.zsh.initContent = ''
    eval "$(/opt/homebrew/bin/brew shellenv)"
  '';
}
