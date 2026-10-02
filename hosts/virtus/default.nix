# virtus: desktop at Técnico (DEI/RNL)
{ pkgs, ... }:
{
  imports = [
    ./hardware.nix
    ./sleep.nix
    ./printer.nix
    ../../modules/common
    ../../modules/desktop
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Fixed address on Técnico's network (no NetworkManager here)
  networking.networkmanager.enable = false;
  networking = {
    interfaces.enp2s0 = {
      ipv4.addresses = [{
        address = "193.136.164.203";
        prefixLength = 27;
      }];
      ipv6.addresses = [{
        address = "2001:690:2100:82::203";
        prefixLength = 64;
      }];
    };
    defaultGateway = "193.136.164.222";
    defaultGateway6 = "2001:690:2100:82::ffff:1";
    nameservers = ["1.1.1.1" "193.136.164.1" "193.136.164.2" "1.0.0.1"];
  };

  # SSH: only with keys, no passwords
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    settings.ClientAliveInterval = 60;
    settings.ClientAliveCountMax = 2;
  };

  # Apps only this machine needs (the rest come from modules/desktop)
  environment.systemPackages = with pkgs; [
    dbeaver-bin
    firefox
  ];

  # The NixOS version this machine was first installed with. Don't change it.
  system.stateVersion = "25.05";
}
