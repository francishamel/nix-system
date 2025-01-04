{ config, lib, ... }:
let
  inherit (lib) mkOption types;

  cfg = config.hm._1password;
in
{
  options = {
    hm._1password.sockPath = mkOption {
      type = types.str;
    };
    hm._1password.sshProgram = mkOption {
      type = types.str;
    };
  };

  config = {
    programs = {
      git.extraConfig = {
        commit.gpgsign = true;
        gpg = {
          format = "ssh";
          ssh.program = cfg.sshProgram;
        };
        user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEuLaEvAkPRVZ5v7uVOxM+Te9n/iJom7RSZogNHK+Jd3";
      };

      ssh.extraConfig = ''
        IdentityAgent "${cfg.sockPath}"
      '';

      zsh = {
        initExtra = ''
          SSH_AUTH_SOCK="${cfg.sockPath}"
          # This is needed for autocompletion to work with op plugin
          setopt completealiases
        '';
        shellAliases = {
          gh = "op plugin run -- gh";
        };
      };
    };
  };
}
