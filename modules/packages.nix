{ pkgs, ... }:
{
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
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
    zip
    ];
}