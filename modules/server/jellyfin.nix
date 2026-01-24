{ config, pkgs, ... }:

{
    services.jellyfin = {
        enable = true;
        openFirewall = false; # caddy handles this
        user = "jellyfin";
    };

    users.users.jellyfin.extraGroups = [ "users" "video" "render" ];
}