{ pkgs, username, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";

  home.stateVersion = "23.11"; # Update this to match your system's stateVersion

  # You can start adding user-specific packages here
  home.packages = with pkgs; [
    htop
    neofetch
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
}