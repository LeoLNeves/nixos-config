{ pkgs, ... }:
{
  # Lets downloaded programs that weren't built for NixOS run
  programs.nix-ld.enable = true;

  virtualisation.docker.enable = true;

  # Programming and command-line tools
  environment.systemPackages = with pkgs; [
    # Editors
    neovim
    vscode
    opencode

    # Languages
    jdk
    maven
    rustc
    cargo
    (python3.withPackages (ps: with ps; [ numpy pillow matplotlib openpyxl ]))

    # Git
    git
    git-lfs

    # Command-line tools
    docker
    rclone
    wget
    jq
    ripgrep
    file
    util-linux # Provides hexdump
    xxd
    binutils # Provides strings
    poppler-utils # PDF tools (pdftotext, ...)

    # Archives
    zip
    unzip
    p7zip

    # Audio & video
    ffmpeg
    sox
    mkvtoolnix
  ];
}
