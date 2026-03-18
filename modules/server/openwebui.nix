{ ... }:
{
  services.open-webui = {
    enable = true;
    openFirewall = false; # caddy handles this
    port = 7860;
    environment = {
      DEFAULT_PROMPT_SUGGESTIONS = "false";

      ENABLE_EASTER_EGGS = "False";
      ENABLE_USER_STATUS = "False";
      ENABLE_TAGS_GENERATION = "False";
      ENABLE_CHANNELS = "False";
      
      ENABLE_SIGNUP = "Olympia";
      WEBUI_NAME = "";
      ENABLE_PERSISTENT_CONFIG = "False";
    };
  };
}