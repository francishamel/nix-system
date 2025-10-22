{ config, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./disk-config.nix
  ];

  boot.loader.systemd-boot.enable = true;

  networking.networkmanager.enable = true;

  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  users.users.${config.flake.meta.user.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "qwerty12345";
  };

  programs.firefox.enable = true;

  programs.zsh.enable = true;

  system.stateVersion = "24.11";
}
