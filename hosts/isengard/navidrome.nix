{ ... }:
{
  services.navidrome = {
    enable = true;
    openFirewall = false; # caddy handles this
    settings = {
      Address = "127.0.0.1"; # Only listen internally
      Port = 4533;
      MusicFolder = "/var/lib/music";
    };
  };
}