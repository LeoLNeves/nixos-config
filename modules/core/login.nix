{ pkgs, username, ... }:
let
  wallpaper = ../../wallpapers/wallpaper.jpg;

  # Blurred and darkened copy of the wallpaper, like hyprlock's background
  background = pkgs.runCommand "login-background.jpg" { nativeBuildInputs = [ pkgs.imagemagick ]; } ''
    magick ${wallpaper} -blur 0x24 -modulate 55,120 $out
  '';

  # The login screen theme: sddm-theme/Main.qml plus its settings
  theme = pkgs.runCommand "sddm-theme-shire" { } ''
    mkdir -p $out/share/sddm/themes/shire
    cp ${./sddm-theme}/* $out/share/sddm/themes/shire/
    cp ${
      (pkgs.formats.ini { }).generate "theme.conf" {
        General = {
          background = "${background}";
          user = username;
        };
      }
    } $out/share/sddm/themes/shire/theme.conf
  '';
in
{
  # Login screen
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true; # runs on Wayland, so no X server is needed
    theme = "shire";
  };
  services.displayManager.defaultSession = "hyprland";

  environment.systemPackages = [ theme ];

  # The login screen only sees fonts installed for the whole system
  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];
}
