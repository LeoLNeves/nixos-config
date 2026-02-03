{ host, pkgs, ... }:
{

    networking.wireguard.interfaces.wg1 = {
    # Recovered from the startup script
    ips = [ 
        "192.168.20.89/24" 
        "fd92:3315:9e43:c490::89/64" 
    ];

    # Recovered from the private key script
    # ⚠️ Make sure this file exists on your disk!
    privateKeyFile = "/home/leo/wireguard-keys/private";

    peers = [
        {
        # Peer details recovered from the peer script
        publicKey = "g08PXxMmzC6HA+Jxd+hJU0zJdI6BaQJZMgUrv2FdLBY=";
        endpoint = "193.136.164.211:34266";
        persistentKeepalive = 25;

        allowedIPs = [
            "193.136.164.0/26"
            "193.136.164.64/26"
            "193.136.164.128/26"
            "193.136.164.215/32"
            "193.136.154.0/24"
            "10.16.64.0/18"
            "2001:690:2100:80::/62"
            "193.136.128.24/29"
            "146.193.33.81/32"
            "192.168.154.0/24"
        ];
        }
    ];
    };


    networking.networkmanager.dns = "none";
    networking.nameservers = [ "1.1.1.1" "1.0.0.1" ];
    networking.hostName = host;
    networking.networkmanager.enable = true;
}