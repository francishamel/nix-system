{
  flake.modules.homeManager.base =
    { pkgs, ... }:
    {
      programs.claude-code.plugins.eli5 = "${
        pkgs.fetchFromGitHub {
          owner = "anthropics";
          repo = "claude-plugins-community";
          rev = "a727be1c7bd6064419b6f60d71993a19198adc17";
          sparseCheckout = [ "eli5" ];
          hash = "sha256-vxZDVikkt2CL0oMBzbK3bwQQVuPi1spvVPLsEDBYjvE=";
        }
      }/eli5";
    };
}
