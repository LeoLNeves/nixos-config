{ pkgs, username, ... }:

{
  # 1. Import all your separate modules
  imports = [
    ./hyprland.nix
    ./alacritty.nix
    ./neovim.nix
    ./starship.nix
    ./launcher.nix
    ./fastfetch.nix
    ./shell.nix
    ./hyprpaper.nix
    ./tmux.nix
  ];

  # 2. Core settings
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "23.11";

  # 3. Basic packages that don't need dedicated config files
  home.packages = with pkgs; [
    htop
    nerd-fonts.jetbrains-mono
  ];

  # 4. Global Theming (Dark mode & ordinary cursor)
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
    size = 24;
  };

  # 5. Let Home Manager manage itself
  programs.home-manager.enable = true;
}
