{ pkgs, ... }:
let
  # Switches the display off/on. The laptop itself keeps running
  screen = state: "${pkgs.wlopm}/bin/wlopm --${state} '*'";
in
{
  # Locks the screen on its own (lid closed, or no keyboard/mouse for a while)
  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock"; # don't open a second lock screen
        before_sleep_cmd = "loginctl lock-session"; # lock before the laptop sleeps
        after_sleep_cmd = screen "on"; # make sure the display is on after waking up
      };

      # Times are counted from the last keyboard/mouse use, in seconds
      listener = [
        # After 1 minute: lock
        {
          timeout = 60;
          on-timeout = "loginctl lock-session";
        }
        # A few seconds later: display off (move the mouse or press a key to turn it back on)
        {
          timeout = 63;
          on-timeout = screen "off";
          on-resume = screen "on";
        }
        # After 10 minutes: suspend (sleep), like closing the lid
        {
          timeout = 600;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
