{ ... }:
{
    # Open Firewall
    networking.firewall.allowedTCPPorts = [ 80 443 ];

    services.caddy = {
        enable = true;
        virtualHosts = {

        "leonardoneves.com" = {
            extraConfig = ''
            root * /var/www/leonardoneves
            file_server
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