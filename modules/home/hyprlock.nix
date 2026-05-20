{ ... }: {
  programs.hyprlock = {
    enable = true;
    
    settings = {
      general = {
        no_fade_in = false;
        no_fade_out = false;
        hide_cursor = true;
        grace = 0;
        disable_loading_bar = true;
        ignore_empty_input = true;
      };

      background = [
        {
          monitor = "";
          path = "/home/leo/wallpaper.png"; # Pointing to your actual wallpaper!
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "250, 60"; # In Nix, comma-separated values must be strings
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.35;
          dots_center = true;
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(0, 0, 0, 0.2)";
          font_color = "rgb(205, 214, 244)";
          shadow_size = 8;
          shadow_passes = 4;
          shadow_color = "rgba(0, 0, 0, 0.85)";
          shadow_boost = 1.2;
          fade_on_empty = false;
          rounding = -1;
          placeholder_text = ''<span foreground="##cdd6f4">Password</span>''; # Using '' to safely wrap HTML
          hide_input = false;
          position = "0, -200";
          halign = "center";
          valign = "center";
          check_color = "rgb(108, 112, 134)";
          fail_color = "rgb(243, 139, 168)";
          fail_text = "<b>$ATTEMPTS</b>";
          fail_timeout = 2000;
          fail_transition = 300;
        }
      ];

      label = [
        # DATE
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date +"%A, %B %d")"'';
          color = "rgb(205, 214, 244)";
          font_size = 22;
          font_family = "JetBrains Mono";
          shadow_size = 8;
          shadow_passes = 4;
          shadow_color = "rgba(0, 0, 0, 0.85)";
          shadow_boost = 1.2;
          position = "0, 300";
          halign = "center";
          valign = "center";
        }
        # TIME
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date +"%-I:%M")"'';
          color = "rgb(205, 214, 244)";
          font_size = 95;
          font_family = "JetBrains Mono Extrabold";
          shadow_size = 8;
          shadow_passes = 4;
          shadow_color = "rgba(0, 0, 0, 0.85)";
          shadow_boost = 1.2;
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}