{ config, pkgs, domain, ... }:

{
  services.nextcloud = {
    enable = true;
    hostName = "cloud.${domain}";
    
    package = pkgs.nextcloud30; 
    
    database.createLocally = true; 
    
    configureRedis = true;
    maxUploadSize = "16G";
    
    https = true; 

    config = {
      adminuser = "admin";
      adminpassFile = "/var/secrets/nextcloud-admin-pass"; 
    };
  };

  services.nginx = {
    enable = true;
    defaultHTTPListenPort = 8280; 
    
    virtualHosts."nextcloud.${domain}" = {
      listen = [ { addr = "127.0.0.1"; port = 8280; } ];
    };
  };
}