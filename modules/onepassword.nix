{
  nixpkgs.allowedUnfreePackages = [
    "1password"
    "1password-cli"
  ];
  flake.modules = {
    darwin.base = {
      programs._1password.enable = true;
      programs._1password-gui.enable = true;
    };
    nixos.base = {
      programs._1password.enable = true;
      programs._1password-gui = {
        enable = true;
        # TODO: parameterize user
        polkitPolicyOwners = [ "francis" ];
      };
    };
    homeManager.base =
      { config, lib, ... }:
      let
        opCommand = "OP_ACCOUNT=\"my.1password.com\" op plugin run --";
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
              ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
            };
            user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEuLaEvAkPRVZ5v7uVOxM+Te9n/iJom7RSZogNHK+Jd3";
          };

          ssh.extraConfig = ''
            IdentityAgent "${sockPath}"
          '';

          zsh = {
            shellAliases = {
              fly = "${opCommand} fly";
              flyctl = "${opCommand} flyctl";
              gh = lib.mkIf config.programs.gh.enable "${opCommand} gh";
            };

            # This is only needed for macOS. It is properly setup when installed through nixpkgs (it is installed through homebrew in this case.)
            # TODO: properly install 1password
            initContent = ''
              if command -v op >/dev/null; then
                eval "$(op completion zsh)"; compdef _op op
              fi
            '';
          };
        };
      };
  };
}

