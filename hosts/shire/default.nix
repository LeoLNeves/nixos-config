# shire: personal laptop
{ ... }:
{
  imports = [
    ./hardware.nix
    ./vpn.nix
    ../../modules/common
    ../../modules/desktop
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # The NixOS version this machine was first installed with. Don't change it.
  system.stateVersion = "25.05";
}
