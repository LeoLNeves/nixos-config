{ ... }:
{
    # Open Firewall
    networking.firewall.allowedTCPPorts = [ 80 443 ];

    services.caddy = {
        enable = true;
        virtualHosts = {

        "leonardoneves.com" = {
            extraConfig = ''
            root * /var/www/personal_website/public
            file_server
            encode gzip
            '';
        };

        "music.leonardoneves.com" = {
            extraConfig = ''
            reverse_proxy localhost:4533
            '';
        };
        };
    };
}