{pkgs, ...}: {
  services.hyprpaper = {
    enable = true;

    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 20;

      wallpaper = {
        monitor = "";
        path = "${../../wallpapers/wallpaper.jpg}"; # same file as the lock and login screens
        fit_mode = "";
      };
    };
  };

  home.packages = with pkgs; [hyprpaper];
}
