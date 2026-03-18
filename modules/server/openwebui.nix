{ ... }:
{
  services.open-webui = {
    enable = true;
    openFirewall = false; # caddy handles this
  };
}