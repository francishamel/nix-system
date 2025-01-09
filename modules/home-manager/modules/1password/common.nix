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
    home.sessionVariables.SSH_AUTH_SOCK = "${cfg.sockPath}";

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

      zsh.shellAliases = {
        gh = lib.mkIf config.programs.gh.enable "op plugin run -- gh";
      };
    };
  };
}
