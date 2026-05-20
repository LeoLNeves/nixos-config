{ ... }: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        position = "top";
        layer = "top";
        height = 32;
        exclusive = true;

        modules-left = [
          "hyprland/workspaces"
        ];
        
        modules-center = [
          "clock"
        ];
        
        modules-right = [
          "pulseaudio"
          "network"
          "bluetooth"
          "battery"
          "custom/restart"
          "custom/power"
        ];

        "hyprland/workspaces" = {
          "disable-scroll" = true;
          "all-outputs" = true;
          "on-click" = "activate";
          "format" = "{name}";
        };

        "clock" = {
          # Format: 14:30  Wednesday, 20 May
          "format" = "󱑆  {:%H:%M   %A, %d %b}";
          "tooltip-format" = "<tt><small>{calendar}</small></tt>";
        };

        "pulseaudio" = {
          "format" = "{icon}  {volume}%";
          "format-muted" = "󰝟  Muted";
          "format-bluetooth" = "{icon}  {volume}%";
          "format-icons" = {
            "default" = ["󰕿" "󰖀" "󰕾"];
          };
          "scroll-step" = 5;
          # wpctl is the native NixOS pipewire audio controller
          "on-click" = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; 
        };

        "network" = {
          "format-wifi" = "   {signalStrength}%";
          "format-ethernet" = "󰈀   Wired";
          "format-disconnected" = "󰤭   Offline";
          "tooltip-format" = "{essid} ({ifname})";
        };

        "bluetooth" = {
          "format-on" = "";
          "format-off" = "󰂲";
          "format-connected" = "󰂱  {num_connections}";
          "tooltip-format" = "{device_alias}";
        };

        "battery" = {
          "states" = {
            "warning" = 25;
            "critical" = 10;
          };
          "format" = "{icon}  {capacity}%";
          "format-charging" = "󰚥  {capacity}%";
          "format-icons" = ["󰁺" "󰁻" "󰁾" "󰂀" "󰁹"];
        };

        "custom/restart" = {
          "format" = "";
          "tooltip" = false;
          "on-click" = "systemctl reboot";
        };

        "custom/power" = {
          "format" = "⏻";
          "tooltip" = false;
          "on-click" = "systemctl poweroff";
        };
      };
    };

    style = let
      # Your strict custom palette
      black = "#110F14";
      blue  = "#16466F";
      red   = "#B73747";
      white = "#DDE5E6";
    in ''
      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrainsMono Nerd Font";
        font-weight: bold;
        font-size: 14px;
      }

      window#waybar {
        background-color: ${black};
        color: ${white};
      }

      /* --- Workspaces --- */
      #workspaces {
        margin-left: 10px;
      }
      
      #workspaces button {
        padding: 0 10px;
        color: ${white};
        background: transparent;
        transition: all 0.2s ease-in-out;
      }

      #workspaces button.active {
        color: ${blue};
      }

      #workspaces button:hover {
        color: ${blue};
        box-shadow: inset 0 -2px ${blue};
      }

      /* --- Center Clock --- */
      #clock {
        color: ${white};
      }

      /* --- Right Modules --- */
      #pulseaudio,
      #network,
      #bluetooth,
      #battery,
      #custom-restart,
      #custom-power {
        padding: 0 12px;
        color: ${blue}; /* Icons use your accent blue */
      }

      /* Muted Audio uses red */
      #pulseaudio.muted {
        color: ${red};
      }

      /* Battery colors dynamically change */
      #battery {
        color: ${blue};
      }
      #battery.charging {
        color: ${white};
      }
      #battery.warning {
        color: ${white};
      }
      #battery.critical:not(.charging) {
        color: ${red};
        animation: blink 1s steps(2, start) infinite;
      }

      /* Power buttons use red */
      #custom-restart {
        color: ${white};
        padding-right: 5px;
      }
      
      #custom-power {
        color: ${red};
        padding-right: 15px;
      }

      /* Blinking animation for critical battery */
      @keyframes blink {
        to {
          color: ${white};
        }
      }
    '';
  };
}
