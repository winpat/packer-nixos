{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostId = "1eaa9212";

  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
  };

  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
  };

  services.cloud-init.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    tmux
  ];

  networking.firewall.allowedTCPPorts = [
    22
  ];

  system.stateVersion = "22.11";
}
