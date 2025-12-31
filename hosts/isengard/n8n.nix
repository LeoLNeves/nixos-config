{ config, pkgs, domain ... }:

{
  services.n8n = {
    enable = true;
    openFirewall = false; # Caddy handles the public traffic

    # You were right: Use 'environment', not 'settings'
    # This acts as a map: "Variable Name" = "Value"
    environment = {
      # Network
      N8N_HOST = "n8n.${domain}";
      N8N_PORT = "5678";
      N8N_PROTOCOL = "https";
      WEBHOOK_URL = "https://n8n.${domain}/";

      # Config
      NODE_ENV = "production";
      N8N_DIAGNOSTICS_ENABLED = "false";
      GENERIC_TIMEZONE = "Europe/Lisbon";
    };
  };
}