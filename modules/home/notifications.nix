{ pkgs, ... }:
{
  # Notification pop-ups (top-right corner)
  services.mako = {
    enable = true;
    settings = {
      font = "JetBrainsMono Nerd Font 11";
      anchor = "top-right";
      layer = "overlay";
      width = 340;
      height = 140;
      margin = "10";
      padding = "14";
      border-size = 2;
      border-radius = 10;
      max-icon-size = 48;
      default-timeout = 5000; # milliseconds

      # Same palette as waybar
      background-color = "#110F14";
      text-color = "#DDE5E6";
      border-color = "#86AAEC";
      progress-color = "over #1C1E27";

      "urgency=low" = {
        border-color = "#6B7486";
      };

      # Important notifications stay until clicked
      "urgency=critical" = {
        border-color = "#E26C7C";
        default-timeout = 0;
      };
    };
  };

  # Notifies when the battery is low or the charger is plugged/unplugged
  services.poweralertd.enable = true;

  home.packages = [
    pkgs.libnotify # notify-send
  ];
}
