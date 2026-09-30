{ config, ... }:
let
  font = "JetBrainsMono Nerd Font";

  # Same palette as waybar
  white = "rgb(221, 229, 230)";
  blue = "rgb(134, 170, 236)";
  red = "rgb(183, 55, 71)";
  yellow = "rgb(236, 211, 160)";

  shadow = {
    shadow_size = 6;
    shadow_passes = 3;
    shadow_color = "rgba(0, 0, 0, 0.6)";
  };
in
{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
      };

      background = [
        {
          monitor = "";
          path = "${config.home.homeDirectory}/wallpaper.png";
          blur_passes = 3;
          blur_size = 6;
          brightness = 0.55;
          contrast = 1.0;
          vibrancy = 0.2;
          noise = 0.01;
        }
      ];

      label = [
        # TIME
        (shadow // {
          monitor = "";
          text = "$TIME";
          color = white;
          font_size = 110;
          font_family = "${font} ExtraBold";
          position = "0, 160";
          halign = "center";
          valign = "center";
        })
        # DATE
        (shadow // {
          monitor = "";
          text = ''cmd[update:60000] date +"%A, %d %B"'';
          color = white;
          font_size = 20;
          font_family = font;
          position = "0, 50";
          halign = "center";
          valign = "center";
        })
        # USER
        (shadow // {
          monitor = "";
          text = "$USER";
          color = blue;
          font_size = 14;
          font_family = "${font} Bold";
          position = "0, -90";
          halign = "center";
          valign = "center";
        })
      ];

      input-field = [
        (shadow // {
          monitor = "";
          size = "300, 50";
          position = "0, -150";
          halign = "center";
          valign = "center";
          rounding = -1;
          outline_thickness = 2;

          outer_color = blue;
          inner_color = "rgba(17, 15, 20, 0.75)";
          font_color = white;
          font_family = font;
          check_color = yellow;
          fail_color = red;
          capslock_color = yellow;

          dots_size = 0.2;
          dots_spacing = 0.35;
          dots_center = true;
          fade_on_empty = false;
          placeholder_text = "<i>Password</i>";
          fail_text = "<i>$FAIL</i> <b>($ATTEMPTS)</b>";
        })
      ];
    };
  };
}
