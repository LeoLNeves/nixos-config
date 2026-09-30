{ ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow proprietary software (Spotify, Discord, VS Code, ...)
  nixpkgs.config.allowUnfree = true;
}
