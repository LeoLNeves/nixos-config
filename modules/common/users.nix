{ username, ... }:
{
  users.users.${username} = {
    isNormalUser = true;
    description = "Leonardo";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
