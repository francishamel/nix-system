{ config, ... }:
let
  gitEmail = config.flake.meta.user.gitEmail;
  initOrder = config.my.zsh.initOrder;
  signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEuLaEvAkPRVZ5v7uVOxM+Te9n/iJom7RSZogNHK+Jd3";
in
{
  nixpkgs.allowedUnfreePackages = [
    "1password"
    "1password-cli"
  ];
  flake.modules = {
    darwin.base.programs._1password.enable = true;
    homeManager = {
      base =
        {
          config,
          lib,
          pkgs,
          ...
        }:
        {
          options.my.onepassword = {
            agentSocket = lib.mkOption {
              type = lib.types.str;
              description = "Path to the 1Password SSH agent socket, used as SSH_AUTH_SOCK.";
            };

            sshSignProgram = lib.mkOption {
              type = lib.types.str;
              description = "Path to op-ssh-sign, the binary git calls to sign commits and tags.";
            };
          };

          config = {
            home.sessionVariables.SSH_AUTH_SOCK = config.my.onepassword.agentSocket;

            programs.git.settings = {
              commit.gpgsign = true;
              tag.gpgsign = true;
              gpg = {
                format = "ssh";
                ssh = {
                  allowedSignersFile = toString (pkgs.writeText "git-allowed-signers" "${gitEmail} ${signingKey}\n");
                  program = config.my.onepassword.sshSignProgram;
                };
              };
              user.signingkey = signingKey;
            };
          };
        };
      darwin =
        {
          config,
          lib,
          pkgs,
          ...
        }:
        {
          my.onepassword = {
            agentSocket = "${config.home.homeDirectory}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
            sshSignProgram = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
          };

          programs.zsh.initContent = lib.mkOrder initOrder.fpath ''
            fpath=(${pkgs._1password-cli}/share/zsh/site-functions $fpath)
          '';
        };
    };
  };
}
