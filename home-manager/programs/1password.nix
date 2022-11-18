{ config, ... }:

let
  sockPath = "${config.home.homeDirectory}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
in
{
  programs = {
    # Setup commit signing through 1Password
    git.extraConfig = {
      commit.gpgsign = true;
      gpg = {
        format = "ssh";
        ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      };
      user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEuLaEvAkPRVZ5v7uVOxM+Te9n/iJom7RSZogNHK+Jd3";
    };

    ssh.extraConfig = ''
      IdentityAgent "${sockPath}"
    '';

    zsh.initExtra = ''
      # Enable beta preview
      export OP_PLUGINS_SNEAK_PREVIEW="true"

      # Source the generated plugins config file for op
      source ~/.config/op/plugins.sh

      SSH_AUTH_SOCK="${sockPath}"
      if command -v op >/dev/null; then
        eval "$(op completion zsh)"; compdef _op op
      fi
    '';
  };
}
