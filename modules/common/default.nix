{ host, ... }:
{
  # Settings every machine gets
  imports = [
    ./locale.nix
    ./nix.nix
    ./ssh.nix
    ./users.nix
  ];

  networking.hostName = host;
}
