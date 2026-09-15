{ pkgs, ... }:
{
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  # 1. Run your website in the background using Bun
  systemd.services.dstclub-website = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      # Tell Bun exactly where the project lives
      WorkingDirectory = "/var/www/dstclub";
      ExecStart = "${pkgs.bun}/bin/bun /var/www/dstclub/.output/server/index.mjs";
      Restart = "always";
      Environment = "PORT=3000";
    };
  };

  # 2. Configure Caddy to serve CSS/JS directly, and proxy the rest
  services.caddy = {
    enable = true;
    virtualHosts."dstclub.pt".extraConfig = ''
      # Point Caddy to your static files folder
      root * /var/www/dstclub/.output/public
      
      # If the file exists (like CSS or images), serve it directly
      file_server
      
      # If the file DOES NOT exist (like a page route), send it to Bun
      @notStatic {
        not file
      }
      reverse_proxy @notStatic localhost:3000
    '';
  };
}