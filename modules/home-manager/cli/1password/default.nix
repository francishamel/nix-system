{ config, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.modules.cli._1password;

  sockPath = "${config.home.homeDirectory}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
in
{
  options.modules.cli._1password.enable = mkEnableOption "Enable personal home-manager module for 1password.";

  config = mkIf cfg.enable {
    programs = {
      # TODO: Add an option to enable/disable git commit signing through 1 password (+ only enable if git is enabled)
      git.extraConfig = {
        commit.gpgsign = true;
        gpg = {
          format = "ssh";
          ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
        };
        user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEuLaEvAkPRVZ5v7uVOxM+Te9n/iJom7RSZogNHK+Jd3";
      };

      # TODO: Only set this up if ssh is enabled + make this configurable
      ssh.extraConfig = ''
        IdentityAgent "${sockPath}"
      '';

      # TODO: only set this if zsh is enabled
      # TODO: parameterize if we use the beta version
      # TODO: only set SSH_AUTH_SOCK if the option is set to true
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
  };
}
