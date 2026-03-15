{ personal_website, domain, ... }:
{
    # Open Firewall
    networking.firewall.allowedTCPPorts = [ 80 443 ];

    services.caddy = {
        enable = true;
        virtualHosts = {

            "${domain}" = {
                extraConfig = ''
                root * ${personal_website}
                file_server
                encode gzip
                '';
            };
            
            "temporary.${domain}" = {
                extraConfig = ''
                root * /var/lib/temp
                file_server
                '';
            };

            "media.${domain}" = {
                extraConfig = ''
                reverse_proxy localhost:8096
                '';
            };

            "music.${domain}" = {
                extraConfig = ''
                reverse_proxy localhost:4533
                '';
            };

            "n8n.${domain}" = {
                extraConfig = ''
                reverse_proxy localhost:5678
                '';
            };

            "vault.${domain}" = {
                extraConfig = ''
                reverse_proxy localhost:8200
                '';
            };

            "cloud.${domain}" = {
                extraConfig = ''
                reverse_proxy localhost:8280
                '';
        };
    };
}