{ ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Garbage collector: once a day, delete old system versions (older than 5 days)
  # and the files only they were using. The current version is always kept
  nix.gc = {
    automatic = true;
    dates = "daily";
    persistent = true; # if the laptop was off at that time, run it at the next boot
    options = "--delete-older-than 5d";
  };

  # Allow proprietary software (Spotify, Discord, VS Code, ...)
  nixpkgs.config.allowUnfree = true;
}
