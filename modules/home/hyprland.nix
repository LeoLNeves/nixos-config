{ ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "hyprlang";
    
    extraConfig = ''
      monitor=,preferred,auto,1

      input {
          kb_layout = pt
          sensitivity = 0
          scroll_method = 2 fg
          touchpad {
              natural_scroll = true
          }
      }

      general {
          border_size = 0
          gaps_in = 5
          gaps_out = 10
          gaps_workspaces = -10
          layout = master
          resize_on_border = true
          col.active_border = rgba(90ceaaff) rgba(ecd3a0ff) 45deg
          col.inactive_border = rgba(86aaeccc) rgba(93cee9cc) 45deg
      }

      misc {
          disable_hyprland_logo = true
          force_default_wallpaper = 0
      }

      cursor {
          no_hardware_cursors = 0
      }

      decoration {
          rounding = 8
          active_opacity = 1.0
          inactive_opacity = 1.0
          fullscreen_opacity = 1.0
          blur {
              enabled = false
          }
          shadow {
              enabled = false
          }
      }

      animations {
          enabled = true
          bezier = zoom, 0.05, 0.7, 0.1, 1.0
          animation = windows, 1, 1, zoom, slide
          animation = windowsIn, 1, 1, zoom, slide
          animation = windowsOut, 1, 1, zoom, slidevert
          animation = windowsMove, 1, 1, zoom, slide
          animation = fade, 1, 2, zoom
          animation = workspaces, 1, 1, zoom, slide
      }

      master {
          allow_small_split = false
          special_scale_factor = 0.8
          mfact = 0.5
          new_on_top = false
          orientation = left
      }

      bindm = SUPER, mouse:273, resizewindow
      bindm = SUPER, mouse:272, movewindow

      bind = SUPER, Return, exec, alacritty
      bind = SUPER, Space, exec, vicinae toggle
      bind = SUPER, Q, killactive
      bind = SUPER_SHIFT, M, exit
      bind = SUPER_SHIFT, F, fullscreen, 0
      bind = SUPER_SHIFT, Space, togglefloating
      
      bind = SUPER, left, movefocus, l
      bind = SUPER, right, movefocus, r
      bind = SUPER, up, movefocus, u
      bind = SUPER, down, movefocus, d
      
      bind = SUPER_SHIFT, left, movewindow, l
      bind = SUPER_SHIFT, right, movewindow, r
      bind = SUPER_SHIFT, up, movewindow, u
      bind = SUPER_SHIFT, down, movewindow, d
      
      bind = SUPER, 1, workspace, 1
      bind = SUPER, 2, workspace, 2
      bind = SUPER, 3, workspace, 3
      bind = SUPER, 4, workspace, 4
      bind = SUPER, 5, workspace, 5
      
      bind = SUPER_SHIFT, 1, movetoworkspacesilent, 1
      bind = SUPER_SHIFT, 2, movetoworkspacesilent, 2
      bind = SUPER_SHIFT, 3, movetoworkspacesilent, 3
      bind = SUPER_SHIFT, 4, movetoworkspacesilent, 4
      bind = SUPER_SHIFT, 5, movetoworkspacesilent, 5

      exec-once = waybar
    '';
  };
}