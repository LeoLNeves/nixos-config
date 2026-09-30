{ pkgs, ... }:

{
  # Enable Hyprland
  programs.hyprland.enable = true;

  # Optional but highly recommended: an application launcher and a terminal
  environment.systemPackages = with pkgs; [
    kitty      # A great default terminal for Wayland
    wofi       # A simple app launcher
  ];
}