{ pkgs, ... }:
{
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
        wireguard-tools
        brave
        mattermost-desktop
        discord
        neovim
        obsidian
        spotify
        git
        vscode
        docker 
        rclone
        libreoffice-fresh
        zip
    ];
}