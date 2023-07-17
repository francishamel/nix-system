{ config, ... }:

{
  imports = [ ./common.nix ];

  _1password = {
    sockPath = "${config.home.homeDirectory}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
    sshProgram = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
  };

  # This is only needed for macOS. It is properly setup when installed through nixpkgs (it is installed through homebrew in this case.)
  programs.zsh.initExtra = ''
    if command -v op >/dev/null; then
      eval "$(op completion zsh)"; compdef _op op
    fi
  '';
}
