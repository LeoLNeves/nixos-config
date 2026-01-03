{ host, ... }:
{
    networking.networkmanager.dns = "none";
    networking.nameservers = [ "1.1.1.1" "1.0.0.1" ];
    networking.hostName = host;
    networking.networkmanager.enable = true;
}