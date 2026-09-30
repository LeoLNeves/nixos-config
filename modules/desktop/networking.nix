{ ... }:
{
  # Wi-Fi and network connections (pick networks with nmtui or the bar)
  networking.networkmanager.enable = true;

  # Always use Cloudflare DNS instead of the one each network offers
  networking.networkmanager.dns = "none";
  networking.nameservers = [ "1.1.1.1" "1.0.0.1" ];
}
