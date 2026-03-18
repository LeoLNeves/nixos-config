{ ... }:
{
  services.open-webui = {
    enable = true;
    openFirewall = false; # caddy handles this
    port = 7860;
    environment = {
      DEFAULT_PROMPT_SUGGESTIONS = "false";
    };
  };
}