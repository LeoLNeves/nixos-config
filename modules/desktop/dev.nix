{ pkgs, ... }:
{
  # Lets downloaded programs that weren't built for NixOS run
  programs.nix-ld.enable = true;

  virtualisation.docker.enable = true; # also installs the docker command

  # Programming and command-line tools
  environment.systemPackages = with pkgs; [
    # Editors (neovim is set up in modules/home/neovim.nix)
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
    rclone
    wget
    jq
    ripgrep
    file
    xxd # (hexdump comes with NixOS already)
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
