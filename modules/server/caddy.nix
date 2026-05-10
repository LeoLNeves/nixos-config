{ personal_website, domain, caddyr_theme, ... }:
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
            
            "capture.${domain}" = {
                extraConfig = ''
                reverse_proxy localhost:3000
                '';
            };

            "drive.${domain}" = {
                extraConfig = ''
                # 1. Serve the theme's CSS, JS, and Icons
                # The template expects these to live under /Caddyr/
                handle_path /Caddyr/* {
                    root * ${caddyr_theme}
                    file_server
                }

                # 2. Serve the actual files from your server and apply the template
                handle {
                    # Change this to the actual path of the folder you want to share
                    root * /var/lib/my-shared-drive 
                    
                    file_server {
                        # Point browse directly to the template in your Nix store
                        browse ${caddyr_theme}/caddyr.tpl
                        index off
                    }
                }
                encode gzip
                '';
            };
        };
    };
}