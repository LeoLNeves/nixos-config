{ config, pkgs, ... }:

{
  # ... other config ...

  # Enable Flatpak
  services.flatpak.enable = true;
  
  # Optional: XDG portals are often needed for Flatpak file pickers to work correctly
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}