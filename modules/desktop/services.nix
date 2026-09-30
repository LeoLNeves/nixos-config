{ pkgs, ... }:
{
  # Things the GNOME desktop used to turn on for us
  hardware.bluetooth.enable = true;
  services.upower.enable = true; # battery info (waybar, low battery warnings)
  services.power-profiles-daemon.enable = true; # power saver / performance modes
  services.udisks2.enable = true; # USB drives
  services.gvfs.enable = true; # trash, phones and network folders in Files
  services.avahi.enable = true; # finds printers and devices on the network
  services.libinput.enable = true; # touchpad fixes for this laptop model
  services.gnome.gnome-keyring.enable = true; # saved passwords (browser, VS Code, ...)
  services.gnome.gcr-ssh-agent.enable = true; # SSH agent for git
  services.gnome.glib-networking.enable = true; # lets GTK apps use HTTPS
  services.gnome.at-spi2-core.enable = true; # accessibility, some GTK apps expect it
  services.gnome.sushi.enable = true; # press Space in Files to preview a file
  programs.dconf.enable = true; # GTK app settings (dark theme, ...)

  # Default font of GTK apps
  fonts.packages = [ pkgs.adwaita-fonts ];
}
