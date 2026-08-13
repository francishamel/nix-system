{ config, ... }:
let
  gitEmail = config.flake.meta.user.gitEmail;
  signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEuLaEvAkPRVZ5v7uVOxM+Te9n/iJom7RSZogNHK+Jd3";
in
{
  nixpkgs.allowedUnfreePackages = [
    "1password"
    "1password-cli"
  ];
  flake.modules = {
    darwin.base = {
      programs._1password.enable = true;
      # programs._1password-gui.enable = true;
    };
    nixos.base = {
      programs._1password.enable = true;
      programs._1password-gui = {
        enable = true;
        polkitPolicyOwners = [ config.flake.meta.user.username ];
      };
    };
    homeManager = {
      base =
        { config, pkgs, ... }:
        let
          sockPath = "${config.home.homeDirectory}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
        in
        {
          home.sessionVariables.SSH_AUTH_SOCK = sockPath;

          programs = {
            git.settings = {
              commit.gpgsign = true;
              tag.gpgsign = true;
              gpg = {
                format = "ssh";
                ssh = {
                  allowedSignersFile = toString (pkgs.writeText "git-allowed-signers" "${gitEmail} ${signingKey}\n");
                  program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
                };
              };
              user.signingkey = signingKey;
            };

            ssh.extraConfig = ''
              IdentityAgent "${sockPath}"
            '';
          };
        };
      darwin =
        { lib, pkgs, ... }:
        {
          programs.zsh.initContent = lib.mkOrder 550 ''
            fpath=(${pkgs._1password-cli}/share/zsh/site-functions $fpath)
          '';
        };
    };
  };
}
