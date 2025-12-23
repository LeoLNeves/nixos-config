{ ... }:
{
    networking.networkmanager.dns = "none";
    networking.nameservers = [ "1.1.1.1" "1.0.0.1" ];
    networking.hostName = "shire";
    networking.networkmanager.enable = true;
}