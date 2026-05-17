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
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs username; };
        
        # This line changes to point to the new folder structure
        users.${username} = import ../home/default.nix;
    };
}