{ pkgs, ... }:
{
    nixpkgs.config.allowUnfree = true;

    programs.nix-ld.enable = true;

    environment.systemPackages = with pkgs; [
        wireguard-tools
        brave
        mattermost-desktop
        maven
	texliveFull
        jdk
        discord
	audacity
        neovim
        obsidian
        spotify
        git
        vscode
        docker 
        rclone
        libreoffice-fresh
        zip
        rustc
        opencode
	blender
	vlc
	qbittorrent
	gimp
        cargo

              file
              util-linux # Provides hexdump
              xxd
	      sox
	      wget
              binutils   # Provides strings
              unzip
	      mkvtoolnix
	      ffmpeg
 	      p7zip
	      git-lfs
	      poppler-utils
      	      ripgrep
	      jq
              john       # John the Ripper (includes zip2john)
              wordlists  # Packaged wordlists (e.g., RockYou)
	      (python3.withPackages (ps: with ps; [ numpy pillow matplotlib openpyxl ]))

              # --- Steganography & Forensics ---
              steghide
              zsteg
              exiftool
              binwalk
              foremost

              # --- Additional Cracking Tools ---
              fcrackzip
              stegseek
              hashcat

    ];
}
