{ ... }:
{
    services.openssh.enable = true;

    systemd.services.docker.enable = true;
    virtualisation.docker.enable = true;

    services.printing.enable = true;
}