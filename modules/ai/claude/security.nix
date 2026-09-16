{
  # Never let Claude read secrets/credentials. `permissions.deny` is enforced in
  # every mode (including auto mode), so this holds regardless of what auto mode
  # would otherwise approve.
  flake.modules.homeManager.base = {
    programs.claude-code.settings.permissions.deny = [
      # Environment / dotenv files
      "Read(**/.env)"
      "Read(**/.env.*)"
      # SSH keys
      "Read(~/.ssh/**)"
      # Cloud provider credentials
      "Read(~/.aws/**)"
      "Read(~/.config/gcloud/**)"
      # Private keys and generic secrets
      "Read(**/*.pem)"
      "Read(**/id_rsa*)"
      "Read(**/id_ed25519*)"
    ];
  };
}
