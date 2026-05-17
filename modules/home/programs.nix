{ pkgs, ... }:

{
  home.packages = with pkgs; [
    htop
    fastfetch
    # We must install the font his config is asking for
    nerd-fonts.jetbrains-mono
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = false;
    withRuby = false;
  };

  # --- The Other Dude's Wezterm Config (Sanitized) ---
  programs.wezterm = {
    enable = true;
    enableZshIntegration = false;

    extraConfig = ''
      local wezterm = require 'wezterm'
      local config = {}

      config.check_for_updates = false

      config.window_close_confirmation = 'NeverPrompt'
      config.color_scheme = 'Poimandres'
      config.colors = {
        background = "#0f0f0f"
      }
      config.enable_tab_bar = false
      config.font = wezterm.font_with_fallback {
        'JetBrainsMono Nerd Font',
      }
      config.font_size = 12.0
      config.window_background_opacity = 1
      config.audible_bell = "Disabled"

      return config
    '';
  };

  # Enforce Global Dark Mode and Ordinary Cursor
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
}