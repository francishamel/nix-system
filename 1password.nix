{ config, pkgs, lib, ... }:

{
  home = {
    activation = {
      copy-op = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        # To ensure op is able to communicate with the 1Password GUI app, it needs to be at /usr/local/bin/op.
        # To do so, we just overwrite what's there 
        $DRY_RUN_CMD cp -fp ${pkgs._1password}/bin/op /usr/local/bin/op
      '';
    };

    packages = with pkgs; [
      _1password
    ];
  };

  programs = {
    git.extraConfig = {
      commit.gpgsign = true;
      gpg = {
        format = "ssh";
        ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      };
      user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEuLaEvAkPRVZ5v7uVOxM+Te9n/iJom7RSZogNHK+Jd3";
    };

    ssh.extraConfig = ''
      IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    '';

    zsh.initExtra = ''
      path=("/usr/local/bin" $path)
      eval "$(op completion zsh)"; compdef _op op
    '';
  };
}
