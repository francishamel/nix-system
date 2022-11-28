{ ... }:

{
  imports = [
    ../../profiles/home-manager/common.nix
    ../../profiles/home-manager/spin
  ];

  home.username = "spin";
  home.homeDirectory = "/home/spin";
}
