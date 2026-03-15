{ config, pkgs, domain, ... }:

{
  services.nextcloud = {
    enable = true;
    hostName = "cloud.${domain}";
    
    package = pkgs.nextcloud32; 
    
    database.createLocally = true; 

    config.dbtype = "pgsql";
    
    configureRedis = true;
    maxUploadSize = "16G";
    
    https = true; 

    extraAppsEnable = true;
    extraApps = {
      mail = pkgs.fetchNextcloudApp {
        sha256 = "sha256-hmIWE1Z8NqTAqnNPryGf6r0tL+XA4wARil5rCOglEuI=";
        url = "https://github.com/nextcloud-releases/mail/releases/download/v3.7.1/mail-v3.7.1.tar.gz";
        license = "agpl3Plus";
      };
    };

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