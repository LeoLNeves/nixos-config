{pkgs, ...}: {
  services.hyprpaper = {
    enable = true;

    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 20;

      wallpaper = {
        monitor = "";
        path = "~/wallpaper.png";
        fit_mode = "";
      };
    };
  };

  home.packages = with pkgs; [hyprpaper];
}
