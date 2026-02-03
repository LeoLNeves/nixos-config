{ pkgs, ... }:
{
    services.openssh.enable = true;

    systemd.services.docker.enable = true;
    virtualisation.docker.enable = true;

    services.printing = {
        enable = true;
        drivers = [ pkgs.brlaser ]; 
    };

    hardware.printers = {
        ensurePrinters = [
        {
            name = "Brother_MFC_L8900CDW";

            model = "everywhere"; 

            deviceUri = "ipp://print.rnl.tecnico.ulisboa.pt/ipp/print";

            description = "DEI/RNL Printer | Brother MFC-L8900CDW";
            location = "DEI";

            ppdOptions = {
            PageSize = "A4"; 
            };
        }
        ];

        ensureDefaultPrinter = "Brother_MFC_L8900CDW";
    };
}