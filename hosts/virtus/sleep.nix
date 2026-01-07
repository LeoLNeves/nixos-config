{ config, pkgs, ... }:

{
  
  services.xserver.displayManager.gdm.autoSuspend = false;

  systemd.targets = {
    sleep = {
      enable = false;
      unitConfig.DefaultDependencies = "no";
    };
    suspend = {
      enable = false;
      unitConfig.DefaultDependencies = "no";
    };
    hibernate = {
      enable = false;
      unitConfig.DefaultDependencies = "no";
    };
    "hybrid-sleep" = {
      enable = false;
      unitConfig.DefaultDependencies = "no";
    };
  };

  environment.shellAliases = {
    server-mode = "sudo systemctl isolate multi-user.target";
    
    desktop-mode = "sudo systemctl isolate graphical.target";
  };
}