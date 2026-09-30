{ pkgs, ... }:

{
  # Used by the brightness and media keys in hyprland.lua
  home.packages = with pkgs; [
    brightnessctl
    playerctl
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";

    # The actual config lives in hyprland.lua, next to this file
    extraConfig = builtins.readFile ./hyprland.lua;
  };
}
