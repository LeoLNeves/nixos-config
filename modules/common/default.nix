{ host, ... }:
{
  # Settings every machine gets
  imports = [
    ./locale.nix
    ./nix.nix
    ./users.nix
  ];

  networking.hostName = host;
}
