{ ... }:
{
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.caddy = {
    enable = true;
    virtualHosts."dstclub.pt".extraConfig = ''
      root * /var/www/dstclub
      file_server
    '';
  };
}
