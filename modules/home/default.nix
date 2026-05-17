{ username, ... }:

{
  imports = [
    ./programs.nix
    ./hyprland.nix
  ];

  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "23.11";

  programs.home-manager.enable = true;
}