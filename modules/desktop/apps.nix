{ pkgs, ... }:
{
  # Everyday graphical apps
  environment.systemPackages = with pkgs; [
    # Internet & chat
    brave
    discord
    mattermost-desktop
    qbittorrent
    spotify

    # Documents & notes
    libreoffice
    obsidian
    texliveFull

    # Media & creative
    audacity
    blender
    gimp
    vlc

    # Apps that used to come with GNOME
    nautilus # Files
    snapshot # Camera
    baobab # Disk Usage Analyzer
    gnome-calculator # Calculator
    showtime # Video player
    decibels # Audio player
  ];
}
