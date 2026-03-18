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

            "music.${domain}" = {
                extraConfig = ''
                reverse_proxy localhost:4533
                '';
            };

            "vault.${domain}" = {
                extraConfig = ''
                reverse_proxy localhost:8200
                '';
            };

            "ai.${domain}" = {
                extraConfig = ''
                reverse_proxy localhost:7860
                '';
            };
        };
    };
}