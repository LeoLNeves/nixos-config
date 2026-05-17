{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = false; # Kept false to prevent system evaluation warnings
    withNodeJs = true;   # Enabled for modern javascript/typescript plugins
  };

  home.packages = with pkgs; [
    gcc       # Required for TreeSitter compiler extensions
    neovide   # A beautiful graphical user interface for Neovim

    # Nix Development Tools
    nil       # Language Server (Provides auto-complete for nix files)
    statix    # Code Lints and syntax suggestions
    deadnix   # Code cleaner (Finds and flags unused code blocks)
    alejandra # Strict code formatter

    # Language dependencies
    luarocks
    typescript

    # System Utilities
    gdu       # Disk usage analyzer
    ripgrep   # Fast text search engine (Crucial for Neovim telescopes)
  ];
}
