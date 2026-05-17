{ pkgs, username, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";

  home.stateVersion = "23.11"; # Update this to match your system's stateVersion

  # You can start adding user-specific packages here
  home.packages = with pkgs; [
    htop
    fastfetch
  ];

  # --- New Neovim Configuration ---
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Add this block inside your home.nix
  wayland.windowManager.hyprland = {
    enable = true;
    
    settings = let
      # We kept their visual colors and gaps
      border_size = 0;
      gaps_in = 5;
      gaps_out = 10;
      gaps_ws = -10;
      rounding = 8;
      active_border_col = "rgba(90ceaaff) rgba(ecd3a0ff) 45deg";
      inactive_border_col = "rgba(86aaeccc) rgba(93cee9cc) 45deg";

      # Replaced their custom apps with yours
      terminal = "kitty";
      launcher = "wofi --show drun";
    in {
      # Safe default monitor detection
      monitor = [
        ",preferred,auto,1"
      ];

      # Standard Input
      input = {
        sensitivity = -0.7;
        scroll_method = "2 fg";
        touchpad = {
          natural_scroll = true;
        };
      };

      # General Visuals (Copied from other dude)
      general = {
        border_size = border_size;
        gaps_in = gaps_in;
        gaps_out = gaps_out;
        gaps_workspaces = gaps_ws;
        layout = "master";
        resize_on_border = true;

        "col.active_border" = active_border_col;
        "col.inactive_border" = inactive_border_col;
      };

      misc = {
        disable_hyprland_logo = true;
        force_default_wallpaper = 1;
      };

      # Decoration (Copied from other dude)
      decoration = {
        rounding = rounding;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        fullscreen_opacity = 1.0;

        blur = {
          enabled = false; # They had blur disabled, you can change this to true later
        };
        shadow = {
          enabled = false;
        };
      };

      # Animations (Copied their custom smooth animations)
      animations = {
        enabled = true;
        bezier = [
          "zoom, 0.05, 0.7, 0.1, 1.0"
        ];
        animation = [
          "windows, 1, 1, zoom, slide"
          "windowsIn, 1, 1, zoom, slide"
          "windowsOut, 1, 1, zoom, slidevert"
          "windowsMove, 1, 1, zoom, slide"
          "fade, 1, 2, zoom"
          "workspaces, 1, 1, zoom, slide"
        ];
      };

      master = {
        allow_small_split = false;
        special_scale_factor = 0.8;
        mfact = 0.5;
        new_on_top = false;
        orientation = "left";
      };

      # Safe, universally useful Keybinds
      bindm = [
        # Mouse binds for moving and resizing windows
        "SUPER,mouse:273,resizewindow"
        "SUPER,mouse:272,movewindow"
      ];

      bind = [
        # Launchers
        "SUPER, Return, exec, ${terminal}"
        "SUPER, Space, exec, ${launcher}"

        # Window management
        "SUPER, Q, killactive"
        "SUPER_SHIFT, M, exit" # The emergency exit command
        "SUPER_SHIFT, F, fullscreen, 0"
        "SUPER_SHIFT, Space, togglefloating"

        # Change focus with arrow keys
        "SUPER, left,  movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up,    movefocus, u"
        "SUPER, down,  movefocus, d"

        # Move active window with shift + arrow keys
        "SUPER_SHIFT, left,  movewindow, l"
        "SUPER_SHIFT, right, movewindow, r"
        "SUPER_SHIFT, up,    movewindow, u"
        "SUPER_SHIFT, down,  movewindow, d"

        # Workspaces
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"

        # Send window to workspaces
        "SUPER_SHIFT, 1, movetoworkspacesilent, 1"
        "SUPER_SHIFT, 2, movetoworkspacesilent, 2"
        "SUPER_SHIFT, 3, movetoworkspacesilent, 3"
        "SUPER_SHIFT, 4, movetoworkspacesilent, 4"
        "SUPER_SHIFT, 5, movetoworkspacesilent, 5"
      ];
    };
  };
}