{ pkgs, ... }:
{
  # CTF and security tools
  environment.systemPackages = with pkgs; [
    # --- Password cracking ---
    john # John the Ripper (includes zip2john)
    hashcat
    fcrackzip
    wordlists # Packaged wordlists (e.g., RockYou)

    # --- Steganography & Forensics ---
    steghide
    stegseek
    zsteg
    exiftool
    binwalk
    foremost
  ];
}
