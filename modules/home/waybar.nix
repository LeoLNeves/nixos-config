{ pkgs, ... }:
let
  # Same palette as hyprlock and the terminal
  bg = "#110F14";
  white = "#DDE5E6";
  grey = "#6B7486";
  blue = "#86AAEC";
  red = "#E26C7C";
  yellow = "#ECD3A0";
  green = "#90CEAA";

  # Icons are drawn in the accent colour, the text next to them stays white
  accent = text: "<span color='${blue}'>${text}</span>";

  # Opens a terminal program in a small floating window (see the window rule in hyprland.lua)
  floating = app: "alacritty --class ${app} -e ${app}";

  # powermenu - small wofi menu to lock, log out, suspend, restart or shut down
  powermenu = pkgs.writeShellApplication {
    name = "powermenu";
    runtimeInputs = with pkgs; [ wofi coreutils ];
    text = ''
      choice=$(printf '%s\n' "Lock" "Log out" "Suspend" "Restart" "Shut down" \
        | wofi --dmenu --prompt "Power" --width 220 --height 270 --cache-file /dev/null) || exit 0

      case "$choice" in
        "Lock") hyprlock ;;
        "Log out") hyprctl dispatch 'hl.dsp.exit()' ;;
        "Suspend") systemctl suspend ;;
        "Restart") systemctl reboot ;;
        "Shut down") systemctl poweroff ;;
      esac
    '';
  };
in
{
  home.packages = [
    powermenu
    pkgs.pavucontrol # volume mixer (right-click the volume)
    pkgs.bluetuith # bluetooth menu (click the bluetooth icon)
  ];

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        position = "top";
        layer = "top";
        height = 34;
        exclusive = true;

        # Floating bar, lined up with the window gaps
        margin-top = 8;
        margin-left = 10;
        margin-right = 10;

        modules-left = [
          "hyprland/workspaces"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "custom/recording"
          "tray"
          "pulseaudio"
          "backlight"
          "network"
          "bluetooth"
          "battery"
          "custom/power"
        ];

        "hyprland/workspaces" = {
          "disable-scroll" = true;
          "all-outputs" = true;
          "on-click" = "activate";
          "format" = "{name}";
          # Always show 1-5, even when empty
          "persistent-workspaces" = {
            "*" = 5;
          };
        };

        "clock" = {
          # Format: 14:30  ·  Wed 20 May
          "format" = "{:%H:%M  ·  %a %d %b}";
          "tooltip-format" = "<tt><small>{calendar}</small></tt>";
        };

        # Only visible while a screen recording is running; click to stop it
        "custom/recording" = {
          "exec" = "pgrep -x wf-recorder > /dev/null && echo '⏺  REC' || echo";
          "interval" = "once";
          "signal" = 8;
          "format" = "{}";
          "tooltip" = false;
          "on-click" = "screenrecord";
        };

        # Icons of background apps (Discord, Spotify, ...)
        "tray" = {
          "icon-size" = 16;
          "spacing" = 10;
        };

        "pulseaudio" = {
          "format" = "${accent "{icon}"}  {volume}%";
          "format-muted" = "󰝟  muted";
          "format-icons" = {
            "default" = [ "󰕿" "󰖀" "󰕾" ];
          };
          "scroll-step" = 5;
          # wpctl is the native NixOS pipewire audio controller
          "on-click" = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "on-click-right" = "pavucontrol";
        };

        "backlight" = {
          "format" = "${accent "{icon}"}  {percent}%";
          "format-icons" = [ "󰃞" "󰃟" "󰃠" ];
          "tooltip" = false;
        };

        "network" = {
          "format-wifi" = "${accent "{icon}"}  {essid}";
          "format-ethernet" = "${accent "󰈀"}  wired";
          "format-disconnected" = "󰤭  offline";
          "format-icons" = [ "󰤟" "󰤢" "󰤥" "󰤨" ];
          "max-length" = 22;
          "tooltip-format-wifi" = "{essid} ({signalStrength}%)\n{ipaddr}";
          "tooltip-format-ethernet" = "{ifname}\n{ipaddr}";
          "tooltip-format-disconnected" = "Click to pick a network";
          "on-click" = floating "nmtui";
        };

        "bluetooth" = {
          "format-on" = "${accent "󰂯"}";
          "format-off" = "󰂲";
          "format-disabled" = "󰂲";
          "format-connected" = "${accent "󰂱"}  {num_connections}";
          "tooltip-format" = "Bluetooth {status}";
          "tooltip-format-connected" = "{device_enumerate}";
          "tooltip-format-enumerate-connected" = "{device_alias}";
          "on-click" = floating "bluetuith";
        };

        "battery" = {
          "states" = {
            "warning" = 25;
            "critical" = 10;
          };
          "format" = "${accent "{icon}"}  {capacity}%";
          "format-charging" = "󰂄  {capacity}%";
          "format-plugged" = "󰚥  {capacity}%";
          "format-icons" = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          "tooltip-format" = "{timeTo}";
        };

        "custom/power" = {
          "format" = "⏻";
          "tooltip" = false;
          "on-click" = "powermenu";
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        min-height: 0;
        font-family: "JetBrainsMono Nerd Font";
        font-weight: bold;
        font-size: 13px;
      }

      /* The bar itself is invisible: only the three groups have a background */
      window#waybar {
        background: transparent;
        color: ${white};
      }

      .modules-left,
      .modules-center,
      .modules-right {
        background-color: ${bg};
        border-radius: 12px;
        padding: 0 6px;
      }

      /* --- Workspaces --- */
      #workspaces button {
        padding: 0 9px;
        margin: 5px 2px;
        color: ${white};
        background: transparent;
        border-radius: 8px;
        transition: all 0.2s ease-in-out;
      }

      #workspaces button.empty {
        color: ${grey};
      }

      #workspaces button:hover {
        background: rgba(221, 229, 230, 0.12);
        box-shadow: none;
        text-shadow: none;
      }

      #workspaces button.active {
        color: ${bg};
        background: ${blue};
      }

      #workspaces button.urgent {
        color: ${bg};
        background: ${red};
      }

      /* --- Center Clock --- */
      #clock {
        padding: 0 14px;
      }

      /* --- Right Modules --- */
      #custom-recording,
      #tray,
      #pulseaudio,
      #backlight,
      #network,
      #bluetooth,
      #battery,
      #custom-power {
        padding: 0 10px;
      }

      #custom-recording {
        color: ${red};
      }

      #pulseaudio.muted,
      #bluetooth.off,
      #bluetooth.disabled {
        color: ${grey};
      }

      #network.disconnected {
        color: ${red};
      }

      #battery.charging,
      #battery.plugged {
        color: ${green};
      }

      #battery.warning:not(.charging) {
        color: ${yellow};
      }

      #battery.critical:not(.charging) {
        color: ${red};
        animation: blink 1s steps(2, start) infinite;
      }

      #custom-power {
        color: ${red};
        padding-right: 12px;
      }

      /* Blinking animation for critical battery */
      @keyframes blink {
        to {
          color: ${white};
        }
      }

      /* --- Tooltips --- */
      tooltip {
        background: ${bg};
        border: 1px solid ${blue};
        border-radius: 8px;
      }

      tooltip label {
        color: ${white};
      }
    '';
  };
}
