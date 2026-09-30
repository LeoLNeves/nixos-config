{ pkgs, ... }:
let
  # screenshot [region|screen] - saves to ~/Pictures/Screenshots and copies to the clipboard
  screenshot = pkgs.writeShellApplication {
    name = "screenshot";
    runtimeInputs = with pkgs; [ grim slurp wl-clipboard libnotify coreutils ];
    text = ''
      dir="$HOME/Pictures/Screenshots"
      mkdir -p "$dir"
      file="$dir/$(date +%Y-%m-%d_%H-%M-%S).png"

      case "''${1:-region}" in
        region)
          geometry=$(slurp) || exit 0 # Escape cancels
          grim -g "$geometry" "$file"
          ;;
        screen)
          grim "$file"
          ;;
      esac

      wl-copy --type image/png < "$file"
      notify-send -t 3000 -i "$file" "Screenshot saved" "Copied to the clipboard"
    '';
  };

  # screenrecord [region|screen] - starts a recording, or stops the one that is running.
  # Saves to ~/Videos/Recordings (no sound).
  screenrecord = pkgs.writeShellApplication {
    name = "screenrecord";
    runtimeInputs = with pkgs; [ wf-recorder slurp jq libnotify procps coreutils ];
    text = ''
      if pgrep -x wf-recorder > /dev/null; then
        pkill -INT -x wf-recorder
        while pgrep -x wf-recorder > /dev/null; do sleep 0.1; done
        notify-send -t 3000 "Recording saved" "In ~/Videos/Recordings"
      else
        dir="$HOME/Videos/Recordings"
        mkdir -p "$dir"
        file="$dir/$(date +%Y-%m-%d_%H-%M-%S).mp4"

        case "''${1:-region}" in
          region)
            geometry=$(slurp) || exit 0 # Escape cancels
            wf-recorder -g "$geometry" -f "$file" > /dev/null 2>&1 &
            ;;
          screen)
            monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')
            wf-recorder -o "$monitor" -f "$file" > /dev/null 2>&1 &
            ;;
        esac
      fi

      # Refresh the REC indicator in waybar
      pkill -RTMIN+8 waybar || true
    '';
  };
in
{
  home.packages = [
    screenshot
    screenrecord
    pkgs.wl-clipboard # wl-copy / wl-paste
  ];
}
