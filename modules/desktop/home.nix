{ inputs, username, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  # Your user's own config (hyprland, waybar, terminal, ...) lives in modules/home
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    # If a config file already exists (e.g. made by GNOME), rename it to *.backup instead of failing
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs username; };
    users.${username} = import ../home/default.nix;
  };
}
