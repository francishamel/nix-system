{ pkgs, ... }:

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

  users.defaultUserShell = pkgs.zsh;

  users.users.francis = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "qwerty12345";
  };

  programs.firefox.enable = true;

  programs.zsh.enable = true;

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "francis" ];
  };

  system.stateVersion = "24.11";
}
