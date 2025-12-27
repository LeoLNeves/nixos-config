{
  modulesPath,
  lib,
  pkgs,
  ...
} @ args:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk.nix
    ./hardware.nix
  ];
  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };
  services.openssh.enable = true;

  networking.hostName = "isengard";

  # Open Firewall
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.caddy = {
    enable = true;
    virtualHosts."leonardoneves.com" = {
      extraConfig = ''
        root * /var/www/leonardoneves
        file_server
      '';
    };
  };

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
  ];

  users.users.root.openssh.authorizedKeys.keys =
  [
    # change this to your ssh key
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDMMw9d91MxgIrOfr5ucAJaIVUCBRog93x21SEbLlGOh leonardo.neves@tecnico.ulisboa.pt"
  ] ++ (args.extraPublicKeys or []); # this is used for unit-testing this module and can be removed if not needed

  system.stateVersion = "24.05";
}
