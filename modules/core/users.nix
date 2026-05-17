{ pkgs, username, inputs, ... }:
{
    imports = [
        inputs.home-manager.nixosModules.home-manager
    ];

    users.users.${username} = {
        isNormalUser = true;
        description = "Leonardo";
        extraGroups = [ "networkmanager" "wheel"];
        packages = with pkgs; [];
    };

    home-manager = {
        # Use the system-level nixpkgs instead of a separate instance
        useGlobalPkgs = true;
        # Install packages to /etc/profiles instead of ~/.nix-profile
        useUserPackages = true;
        # Pass flake inputs and variables to Home Manager modules
        extraSpecialArgs = { inherit inputs username; };
        
        # Point to your new home.nix file
        users.${username} = import ./home.nix;
    };
}