{ ... }:
{
  # Everything for a machine you sit in front of (laptop / desktop)
  imports = [
    ./apps.nix
    ./audio.nix
    ./ctf.nix
    ./dev.nix
    ./home.nix
    ./hyprland.nix
    ./login.nix
    ./services.nix
  ];
}
