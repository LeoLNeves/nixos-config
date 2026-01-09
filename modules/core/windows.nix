{ config, pkgs, ... }:

{
  virtualisation.oci-containers.backend = "podman";
  virtualisation.oci-containers.containers."windows-server" = {
    image = "dockurr/windows";
    ports = [ "3389:3389" "8006:8006" ];
    environment = {
      VERSION = "11";
      RAM_SIZE = "8G";
      CPU_CORES = "4";
      PASSWORD = "NixOS1234!";

      WAIT = "N";
    };
    volumes = [
      "/home/leo/winapps-data:/storage"
    ];
    # THIS PART FIXES THE STATUS 88 ERROR:
    extraOptions = [
      "--device=/dev/kvm"      # Pass your hardware to the container
      "--cap-add=NET_ADMIN"   # Required for Windows networking
    ];
  };

}