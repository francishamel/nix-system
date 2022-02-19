{ pkgs, ... }: {
  imports = [ ./home-manager.nix ];

  home.packages = with pkgs; [ gobuster nmap wabt wget ];
}
