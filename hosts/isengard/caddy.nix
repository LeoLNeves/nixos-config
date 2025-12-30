{ personal_website, ... }:
{
    # Open Firewall
    networking.firewall.allowedTCPPorts = [ 80 443 ];

    services.caddy = {
        enable = true;
        virtualHosts = {

        "leonardoneves.com" = {
            extraConfig = ''
            root * ${personal_website}
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