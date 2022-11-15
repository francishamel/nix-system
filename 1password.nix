{ config, pkgs, ... }:

{
  # Setup commit signing through 1Password
  programs = {
    git.extraConfig = {
      commit.gpgsign = true;
      gpg = {
        format = "ssh";
        ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      };
      user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEuLaEvAkPRVZ5v7uVOxM+Te9n/iJom7RSZogNHK+Jd3";
    };

    zsh = {
      initExtra = ''
        SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
        if command -v op >/dev/null; then
          eval "$(op completion zsh)"; compdef _op op
        fi
      '';
    };
  };
}
